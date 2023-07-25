import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/api/api.dart';

class PlayerManager {
  late AudioPlayer _audioPlayer;
  final API apiProvider;
  final int episodeId;

  PlayerManager({required this.apiProvider, required this.episodeId}) {
    _init();
  }

  void _init() async {
    _audioPlayer = AudioPlayer();

    await _audioPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(apiProvider.getEpisodeUrl(episodeId)),
        headers: apiProvider.getHeaders(),
      ),
    );

    _audioPlayer.play();

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
