import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rockserwis_podcaster/utils/logger.dart';

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

  final _player = AudioPlayer();
  Timer? _idleTimer;

  late MediaItem localMediaItem;

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
  Future<void> play() => _player.play();

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

  Future<void> setAudioSource(
    AudioSource source,
    MediaItem item,
    Duration initialPosition,
  ) async {
    mediaItem.add(item);

    try {
      await _player.setAudioSource(source, initialPosition: initialPosition);
    } on PlayerException catch (e) {
      logger.d('PlayerException: ${e.message}');
    } on PlayerInterruptedException catch (e) {
      logger.d('PlayerInterruptedException: ${e.message}');
    } catch (e) {
      logger.d("All other errors...");
    }
  }
}
