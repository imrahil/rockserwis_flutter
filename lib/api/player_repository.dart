import 'package:audio_service/audio_service.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/api/audio_handler.dart';
import 'package:rockserwis_podcaster/api/audio_handler_provider.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/progress_bar_state.dart';

part 'player_repository.g.dart';

@Riverpod(keepAlive: true)
class PlayerRepository extends _$PlayerRepository {
  MyAudioHandler get _audioHandler =>
      ref.watch(audioHandlerProvider).requireValue;

  @override
  ProgressBarState build() {
    _audioHandler.playbackState.listen(
      (PlaybackState playbackState) {
        state = state.copyWith(
          processingState: playbackState.processingState,
          playing: playbackState.playing,
          progress: playbackState.position,
          buffered: playbackState.bufferedPosition,
        );
      },
    );

    _audioHandler.mediaItem.listen((MediaItem? mediaItem) {
      state = state.copyWith(
        total: mediaItem?.duration ?? Duration.zero,
      );
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
    _audioHandler.rewind();
  }

  void fastForward() {
    _audioHandler.fastForward();
  }

  void seek(Duration? position) {
    _audioHandler.seek(position ?? const Duration());
  }

  void setAudioSource(Episode currentEpisode) async {
    final apiProvider = ref.read(apiRepositoryProvider);

    AudioSource source = AudioSource.uri(
      Uri.parse(currentEpisode.getEpisodeUrl),
      headers: apiProvider.getHeaders(),
      tag: MediaItem(
        // Specify a unique ID for each media item
        id: currentEpisode.episodeId.toString(),
        // Metadata to display in the notification
        album: DateFormat("yyyy-MM-dd").format(currentEpisode.date),
        title: currentEpisode.name,
        artUri: currentEpisode.imgPath != ""
            ? Uri.parse(apiProvider.getImagePath(currentEpisode.imgPath))
            : null,
      ),
    );

    await _audioHandler.setAudioSource(source);
    _audioHandler.play();
  }
}
