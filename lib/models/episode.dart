import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

part 'episode.freezed.dart';
part 'episode.g.dart';

@Freezed(addImplicitFinal: false)
class Episode with _$Episode {
  const Episode._();

  @Entity(realClass: Episode)
  factory Episode({
    @Id() @Default(0) int id,
    @JsonKey(name: 'schedule_id') required int episodeId,
    int? podcastId,
    @Property(type: PropertyType.dateNano) required DateTime date,
    required String name,
    @JsonKey(name: 'img_path') required String? imgPath,
    @JsonKey(name: 'podcast_duration') required double? episodeDuration,
    @JsonKey(name: 'has_podcast') required bool hasPodcast,
    @Default(false) bool isFavorited,
  }) = _Episode;

  factory Episode.fromJson(Map<String, Object?> json) =>
      _$EpisodeFromJson(json);

  String get getEpisodeTitle {
    String episodeTitle = "$name - ${DateFormat("yyyy-MM-dd").format(date)}";

    return episodeTitle;
  }

  String get getReadableDuration {
    if (episodeDuration == null) {
      return "Unknown duration";
    }

    int totalSeconds = episodeDuration!.toInt();
    int minutes = (totalSeconds / 60).round();

    return "$minutes min";
  }
}
