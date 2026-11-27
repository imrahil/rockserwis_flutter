import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/player_state.dart';
import 'package:rockserwis_podcaster/providers/audio_service.dart';
import 'package:rockserwis_podcaster/providers/download_repository.dart';
import 'package:rockserwis_podcaster/providers/download_settings.dart';
import 'package:rockserwis_podcaster/providers/episode_repository.dart';
import 'package:rockserwis_podcaster/utils/analytics.dart';
import 'package:rockserwis_podcaster/utils/audio_handler.dart';
import 'package:rockserwis_podcaster/utils/media_library.dart';

part 'player_repository.g.dart';

@Riverpod(keepAlive: true)
class PlayerRepository extends _$PlayerRepository {
  MyAudioHandler get _audioHandler =>
      ref.watch(audioServiceProvider).requireValue;

  @override
  EpisodePlayerState build() {
    AudioProcessingState? previousProcessingState;
    _audioHandler.playbackState.listen(
      (PlaybackState playbackState) {
        state = state.copyWith(
          playing: playbackState.playing,
          processingState: playbackState.processingState,
          progress: playbackState.updatePosition,
          buffered: playbackState.bufferedPosition,
        );

        if (playbackState.processingState == AudioProcessingState.completed &&
            previousProcessingState != AudioProcessingState.completed) {
          _onEpisodeCompleted();
        }
        previousProcessingState = playbackState.processingState;
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
              state.currentEpisode!.episodeId,
              state.progress.inMilliseconds,
              state.total.inMilliseconds,
            );
      }
    });

    ref.onDispose(() {
      timer.cancel();
    });

    return EpisodePlayerState(
      playing: false,
      processingState: AudioProcessingState.idle,
      progress: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    );
  }

  Future<void> _onEpisodeCompleted() async {
    final episode = state.currentEpisode;
    if (episode == null) return;

    ref.read(analyticsProvider).logEpisodeComplete(episode);

    if (!ref.read(downloadSettingsProvider).autoDeleteAfterPlayed) return;
    if (episode.downloadedPath == null) return;

    await ref.read(downloadRepositoryProvider).deleteDownload(episode);
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

  void skipToPrevious() async {
    if (state.episodes.isNotEmpty) {
      final currentIndex = state.episodes.indexWhere(
          (episode) => episode.episodeId == state.currentEpisode?.episodeId);

      if (currentIndex > 0 && currentIndex < state.episodes.length) {
        await stop();

        setAudioSource(state.episodes[currentIndex - 1]);
      }
    }
  }

  void skipToNext() async {
    final currentIndex = state.episodes.indexWhere(
        (episode) => episode.episodeId == state.currentEpisode?.episodeId);

    if (currentIndex >= 0 && currentIndex < state.episodes.length - 1) {
      await stop();

      setAudioSource(state.episodes[currentIndex + 1]);
    }
  }

  void updateProgress(Duration position) {
    ref.read(allEpisodesProvider.notifier).updateProgress(
          state.currentEpisode!.episodeId,
          position.inMilliseconds,
          state.total.inMilliseconds,
        );
  }

  void setEpisodes(List<Episode> episodes) {
    state = state.copyWith(
      episodes: episodes,
    );
  }

  Future<void> setAudioSource(Episode currentEpisode) async {
    state = state.copyWith(
      currentEpisode: currentEpisode,
    );

    // update episode's timestamp
    await ref
        .read(allEpisodesProvider.notifier)
        .updateTimestamp(currentEpisode.episodeId);

    final apiProvider = ref.read(apiRepositoryProvider);
    final item = MediaLibrary.episodeMediaItem(
      currentEpisode,
      imageUrl: apiProvider.getImagePath,
    );

    final localPath = currentEpisode.downloadedPath;
    final hasLocal = localPath != null && File(localPath).existsSync();

    AudioSource source = hasLocal
        ? AudioSource.file(localPath)
        : AudioSource.uri(
            Uri.parse(currentEpisode.getEpisodeUrl),
            headers: apiProvider.getHeaders(),
          );

    final loaded = await _audioHandler.setAudioSource(
        source,
        item,
        currentEpisode.progress > 0
            ? Duration(milliseconds: currentEpisode.progress)
            : Duration.zero);
    // On failure the handler has told the UI, which offers a retry.
    if (!loaded) return;
    _audioHandler.play();

    ref
        .read(analyticsProvider)
        .logEpisodePlay(currentEpisode, fromDownload: hasLocal);
  }
}
