import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';

class MyAudioHandler extends BaseAudioHandler with SeekHandler {
  final _player = AudioPlayer();

  var logger = Logger();

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
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> rewind() async {
    final currentPosition = _player.position;
    final newPosition = currentPosition - const Duration(seconds: 30);
    _player.seek(newPosition.isNegative ? Duration.zero : newPosition);
  }

  @override
  Future<void> fastForward() async {
    final currentPosition = _player.position;
    final newPosition = currentPosition + const Duration(seconds: 30);
    _player.seek(newPosition);
  }

  Future<void> setAudioSource(AudioSource source, MediaItem item) async {
    mediaItem.add(item);

    try {
      await _player.setAudioSource(source);
    } on PlayerException catch (e) {
      logger.d('PlayerException: ${e.message}');
    } on PlayerInterruptedException catch (e) {
      logger.d('PlayerInterruptedException: ${e.message}');
    } catch (e) {
      logger.d("All other errors...");
    }
  }
}
