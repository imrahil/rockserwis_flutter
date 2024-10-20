import 'package:audio_service/audio_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rockserwis_podcaster/models/episode.dart';

part 'progress_bar_state.freezed.dart';

@freezed
class ProgressBarState with _$ProgressBarState {
  factory ProgressBarState({
    required bool playing,
    required AudioProcessingState processingState,
    required Duration progress,
    required Duration buffered,
    required Duration total,
    Episode? episode,
  }) = _ProgressBarState;
}
