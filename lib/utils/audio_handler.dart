import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rockserwis_podcaster/utils/logger.dart';
import 'package:rockserwis_podcaster/utils/media_library.dart';

class MyAudioHandler extends BaseAudioHandler with SeekHandler {
  /// How long the media session (and its foreground service) is kept alive
  /// while playback is paused or finished.
  ///
  /// Android 17 only lets apps play audio from the background while they hold
  /// a media playback foreground service that was started while the app was
  /// visible (or from a notification / media button). The service is
  /// therefore kept in the foreground across pauses so playback can be resumed
  /// from any controller, and is released after this timeout, as recommended
  /// by https://developer.android.com/about/versions/17/changes/bg-audio
  static const idleTimeout = Duration(minutes: 10);

  // Send request headers (the session cookie) natively instead of through
  // just_audio's local Dart HTTP proxy. The proxy only handles HttpException,
  // so any SocketException while streaming (lost connection, failed DNS
  // lookup) escaped as an uncaught async error. Natively, network failures are
  // reported through the player's error stream instead.
  //
  // Buffer up to 15 minutes ahead when streaming (the default is under a
  // minute), so a short loss of connection doesn't stop playback.
  final _player = AudioPlayer(
    useProxyForRequestHeaders: false,
    audioLoadConfiguration: const AudioLoadConfiguration(
      androidLoadControl: AndroidLoadControl(
        minBufferDuration: Duration(minutes: 10),
        maxBufferDuration: Duration(minutes: 15),
        // Let the durations above, not the default size limit (about 13 MB),
        // decide how much is buffered.
        prioritizeTimeOverSizeThresholds: true,
      ),
      darwinLoadControl: DarwinLoadControl(
        preferredForwardBufferDuration: Duration(minutes: 15),
      ),
    ),
  );
  Timer? _idleTimer;

  late MediaItem localMediaItem;

  /// What Android Auto can browse and play. Set by mediaLibraryProvider once
  /// the database is open; until then the browse tree is empty.
  MediaLibrary? mediaLibrary;

  /// Whether an episode has been loaded since the app started. Set before the
  /// source is loaded, so a source that fails to load is not retried by
  /// [play] over and over.
  bool _sourceRequested = false;

  /// The last loaded source, kept so playback can be retried after an error.
  AudioSource? _source;

  /// Where to resume [_source] from when it is reloaded by [play].
  Duration _resumePosition = Duration.zero;

  /// Whether playback stopped because of an error (e.g. the connection was
  /// lost) and that error has been reported.
  bool _failed = false;

  /// Whether the next [play] has to load [_source] instead of resuming: after
  /// an error the platform player has to be prepared again, and after
  /// [replaceSource] while nothing was loaded, the new source isn't loaded
  /// yet.
  bool _needsReload = false;

  final _playbackErrors = StreamController<PlayerException>.broadcast();

  /// Emits once each time playback stops because of an error, so the UI can
  /// tell the user and offer a retry.
  Stream<PlayerException> get playbackErrors => _playbackErrors.stream;

  /// Whether the current source is streamed over the network, as opposed to
  /// a downloaded file.
  bool get isStreaming {
    final source = _source;
    return source is UriAudioSource && source.uri.scheme.startsWith('http');
  }

  MyAudioHandler() {
    _player.playbackEventStream.listen((event) {
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.rewind,
          if (_player.playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.fastForward,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        playing: _player.playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: event.currentIndex,
      ));
    });

    _player.playerStateStream.listen(_updateIdleTimer);

    _player.errorStream.listen(_onPlaybackError);

    _player.positionStream.listen((updatePosition) {
      playbackState.add(
        playbackState.value.copyWith(updatePosition: updatePosition),
      );
    });

    _player.bufferedPositionStream.listen((bufferedPosition) {
      playbackState.add(
        playbackState.value.copyWith(bufferedPosition: bufferedPosition),
      );
    });

    _player.durationStream.listen((duration) {
      mediaItem.add(mediaItem.value?.copyWith(duration: duration));
    });
  }

  @override
  Future<void> play() async {
    // Nothing loaded yet, e.g. the app was started in the background by
    // Android Auto or by the system's media resumption controls: resume the
    // last played episode instead of doing nothing.
    final library = mediaLibrary;
    if (!_sourceRequested && library != null) {
      if (await library.playLastPlayed()) return;
    }
    final source = _source;
    if (_needsReload && source != null) {
      if (!await _load(source, _resumePosition)) return;
    }
    await _player.play();
  }

  @override
  Future<List<MediaItem>> getChildren(String parentMediaId,
          [Map<String, dynamic>? options]) async =>
      await mediaLibrary?.getChildren(parentMediaId) ?? const [];

  @override
  Future<MediaItem?> getMediaItem(String mediaId) async =>
      mediaLibrary?.getMediaItem(mediaId);

  @override
  Future<void> playFromMediaId(String mediaId,
      [Map<String, dynamic>? extras]) async {
    await mediaLibrary?.playFromMediaId(mediaId);
  }

  @override
  Future<void> playFromSearch(String query,
      [Map<String, dynamic>? extras]) async {
    await mediaLibrary?.playFromSearch(query);
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    _cancelIdleTimer();
    // Moving to the idle state makes audio_service stop its foreground service.
    await _player.stop();
  }

  void _updateIdleTimer(PlayerState state) {
    final inactive = state.processingState == ProcessingState.completed ||
        (!state.playing && state.processingState == ProcessingState.ready);

    if (!inactive) {
      _cancelIdleTimer();
    } else {
      _idleTimer ??= Timer(idleTimeout, _onIdleTimeout);
    }
  }

  void _cancelIdleTimer() {
    _idleTimer?.cancel();
    _idleTimer = null;
  }

  Future<void> _onIdleTimeout() async {
    _idleTimer = null;
    logger.d('Playback inactive for $idleTimeout, releasing media session');

    if (_player.processingState == ProcessingState.completed) {
      // just_audio keeps `playing` true after completion. Pause and rewind so
      // a later play() starts the episode again instead of completing at once.
      await _player.pause();
      await _player.seek(Duration.zero);
    }
    // The audio source is kept, so play() later reloads it and resumes from
    // the current position. That play() comes from the UI, the notification
    // or a media button, so the foreground service may be started again.
    await stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  Duration customRewind() {
    final currentPosition = _player.position;

    var newPosition = currentPosition - const Duration(seconds: 30);
    newPosition = newPosition.isNegative ? Duration.zero : newPosition;
    _player.seek(newPosition);

    return newPosition;
  }

  Duration customFastForward() {
    final currentPosition = _player.position;
    final newPosition = currentPosition + const Duration(seconds: 30);
    _player.seek(newPosition);

    return newPosition;
  }

  /// Loads [source] for [item]. Returns whether it loaded; if it failed
  /// because of an error, [playbackErrors] has reported it.
  Future<bool> setAudioSource(
    AudioSource source,
    MediaItem item,
    Duration initialPosition,
  ) async {
    _sourceRequested = true;
    _source = source;
    mediaItem.add(item);

    return _load(source, initialPosition);
  }

  /// Replaces the current source with [source] for the same episode (its
  /// download finished while it was streaming), keeping the position and
  /// whether it is playing.
  Future<void> replaceSource(AudioSource source) async {
    if (_source == null) return;
    // Nothing more to play; replacing the source would only restart it.
    if (_player.processingState == ProcessingState.completed) return;

    _source = source;
    if (_needsReload || _player.processingState == ProcessingState.idle) {
      // Nothing is loaded (after an error or stop()): the next play() loads
      // the new source from where playback stopped.
      if (!_needsReload) _resumePosition = _player.position;
      _needsReload = true;
      return;
    }

    final wasPlaying = _player.playing;
    if (await _load(source, _player.position) && wasPlaying) {
      // play() completes only when playback pauses, so don't wait for it.
      unawaited(_player.play());
    }
  }

  Future<bool> _load(AudioSource source, Duration initialPosition) async {
    _failed = false;
    _needsReload = false;
    _resumePosition = initialPosition;
    try {
      await _player.setAudioSource(source, initialPosition: initialPosition);
      return true;
    } on PlayerException catch (e) {
      // Skip if another episode was loaded meanwhile: it reports its own errors.
      if (identical(source, _source)) _onPlaybackError(e);
    } on PlayerInterruptedException catch (e) {
      // Another load or stop() interrupted this one: not an error.
      logger.d('PlayerInterruptedException: ${e.message}');
    } catch (e, st) {
      logger.e('Could not load the audio source', error: e, stackTrace: st);
    }
    return false;
  }

  void _onPlaybackError(PlayerException error) {
    logger.w('Playback error ${error.code}: ${error.message}');
    // A failed load reports the same error through the error stream and the
    // setAudioSource() call: only tell the UI once.
    if (_failed) return;
    _failed = true;
    _needsReload = true;
    if (_player.position > Duration.zero) _resumePosition = _player.position;
    // Show the play button instead of a player stuck "playing" nothing.
    _player.pause().catchError((Object _) {});
    _playbackErrors.add(error);
  }
}
