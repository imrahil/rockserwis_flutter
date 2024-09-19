import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';

class PlayerManager {
  late AudioPlayer _audioPlayer;

  var logger = Logger();

  PlayerManager() {
    _init();
  }

  void _init() async {
    _audioPlayer = AudioPlayer(
        userAgent: "Rockserwis Podcaster", useProxyForRequestHeaders: false);

    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;

      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;

      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;

      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
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

  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );

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
    } catch (e) {
      logger.d("PlayerInterruptedException");
    }
  }
}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });

  final Duration current;
  final Duration buffered;
  final Duration total;
}

enum ButtonState { paused, playing, loading }
