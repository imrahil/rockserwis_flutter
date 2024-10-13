import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';

class MyAudioHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  var logger = Logger();

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

  Future<void> setAudioSource(AudioSource source) async {
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
