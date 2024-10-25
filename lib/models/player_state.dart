import 'package:audio_service/audio_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rockserwis_podcaster/models/episode.dart';

part 'player_state.freezed.dart';

@freezed
class EpisodePlayerState with _$EpisodePlayerState {
  factory EpisodePlayerState({
    required bool playing,
    required AudioProcessingState processingState,
    required Duration progress,
    required Duration buffered,
    required Duration total,
    Episode? currentEpisode,
    @Default([]) List<Episode> episodes,
  }) = _EpisodePlayerState;
}
