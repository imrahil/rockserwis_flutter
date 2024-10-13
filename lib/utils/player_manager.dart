import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';

class PlayerManager {
  late AudioPlayer _audioPlayer;

  var logger = Logger();

  PlayerManager() {
    _init();
  }

  void _init() async {
    // _audioPlayer = AudioPlayer(
    //   userAgent: "Rockserwis Podcaster",
    //   useProxyForRequestHeaders: false,
    // );

    // _audioPlayer.positionStream.listen((position) {
    //   final oldState = progressNotifier.value;

    //   progressNotifier.value = ProgressBarState(
    //     progress: position,
    //     buffered: oldState.buffered,
    //     total: oldState.total,
    //   );
    // });

    // _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
    //   final oldState = progressNotifier.value;

    //   progressNotifier.value = ProgressBarState(
    //     playing: false,
    //     progress: oldState.current,
    //     buffered: bufferedPosition,
    //     total: oldState.total,
    //   );
    // });

    // _audioPlayer.durationStream.listen((totalDuration) {
    //   final oldState = progressNotifier.value;

    //   progressNotifier.value = ProgressBarState(
    //     playing: false,
    //     progress: oldState.current,
    //     buffered: oldState.buffered,
    //     total: totalDuration ?? Duration.zero,
    //   );
    // });
  }

  AudioPlayer getAudioPlayer() => _audioPlayer;

  void dispose() {
    _audioPlayer.dispose();
  }

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  // final progressNotifier = ValueNotifier<ProgressBarState>(
  //   ProgressBarState(
  //     playing: false,
  //     progress: Duration.zero,
  //     buffered: Duration.zero,
  //     total: Duration.zero,
  //   ),
  // );

  void rewind() {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition - const Duration(seconds: 30);
    _audioPlayer.seek(newPosition.isNegative ? Duration.zero : newPosition);
  }

  void fastForward() {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition + const Duration(seconds: 30);
    _audioPlayer.seek(newPosition);
  }

  Future<void> setAudioSource(AudioSource source) async {
    try {
      await _audioPlayer.setAudioSource(source);
    } on PlayerException catch (e) {
      logger.d('PlayerException: ${e.message}');
    } on PlayerInterruptedException catch (e) {
      logger.d('PlayerInterruptedException: ${e.message}');
    } catch (e) {
      logger.d("All other errors...");
    }
  }
}
