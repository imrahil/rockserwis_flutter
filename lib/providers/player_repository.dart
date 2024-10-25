import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/progress_bar_state.dart';
import 'package:rockserwis_podcaster/providers/audio_service.dart';
import 'package:rockserwis_podcaster/providers/episode_repository.dart';
import 'package:rockserwis_podcaster/utils/audio_handler.dart';

part 'player_repository.g.dart';

@Riverpod(keepAlive: true)
class PlayerRepository extends _$PlayerRepository {
  MyAudioHandler get _audioHandler =>
      ref.watch(audioServiceProvider).requireValue;

  @override
  ProgressBarState build() {
    _audioHandler.playbackState.listen(
      (PlaybackState playbackState) {
        state = state.copyWith(
          playing: playbackState.playing,
          processingState: playbackState.processingState,
          progress: playbackState.updatePosition,
          buffered: playbackState.bufferedPosition,
        );
      },
    );

    _audioHandler.mediaItem.listen((item) {
      state = state.copyWith(
        total: item?.duration ?? Duration.zero,
      );
    });

    Timer timer = Timer.periodic(Duration(seconds: 30), (timer) {
      if (state.playing) {
        ref.read(allEpisodesProvider.notifier).updateProgress(
              state.episode!.episodeId,
              state.progress.inMilliseconds,
              state.total.inMilliseconds,
            );
      }
    });

    ref.onDispose(() {
      timer.cancel();
    });

    return ProgressBarState(
      playing: false,
      processingState: AudioProcessingState.idle,
      progress: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    );
  }

  Future<void> play() async {
    await _audioHandler.play();
  }

  Future<void> pause() async {
    await _audioHandler.pause();
  }

  Future<void> stop() async {
    await _audioHandler.stop();
  }

  void rewind() {
    final position = _audioHandler.customRewind();

    updateProgress(position);
  }

  void fastForward() {
    final position = _audioHandler.customFastForward();

    updateProgress(position);
  }

  void seek(Duration? position) {
    _audioHandler.seek(position ?? const Duration());

    if (position != null) {
      updateProgress(position);
    }
  }

  void updateProgress(Duration position) {
    ref.read(allEpisodesProvider.notifier).updateProgress(
          state.episode!.episodeId,
          position.inMilliseconds,
          state.total.inMilliseconds,
        );
  }

  void setAudioSource(Episode currentEpisode) async {
    state = state.copyWith(
      episode: currentEpisode,
    );

    // update episode's timestamp
    await ref
        .read(allEpisodesProvider.notifier)
        .updateTimestamp(currentEpisode.episodeId);

    final apiProvider = ref.read(apiRepositoryProvider);

    MediaItem item = MediaItem(
      // Specify a unique ID for each media item
      id: currentEpisode.episodeId.toString(),
      // Metadata to display in the notification
      album: DateFormat("yyyy-MM-dd").format(currentEpisode.date),
      title: currentEpisode.name,
      artUri: currentEpisode.imgPath != ""
          ? Uri.parse(apiProvider.getImagePath(currentEpisode.imgPath))
          : null,
    );

    AudioSource source = AudioSource.uri(
      Uri.parse(currentEpisode.getEpisodeUrl),
      headers: apiProvider.getHeaders(),
    );

    await _audioHandler.setAudioSource(
        source,
        item,
        currentEpisode.progress > 0
            ? Duration(milliseconds: currentEpisode.progress)
            : Duration.zero);
    _audioHandler.play();
  }
}
