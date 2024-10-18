import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';
import 'package:rockserwis_podcaster/api/const.dart';
import 'package:rockserwis_podcaster/models/history_item.dart';

part 'episode.freezed.dart';
part 'episode.g.dart';

@Freezed(addImplicitFinal: false, toJson: false)
class Episode with _$Episode {
  const Episode._();

  @Entity(realClass: Episode)
  factory Episode({
    @Id() @Default(0) int id,
    @JsonKey(name: 'schedule_id') required int episodeId,
    int? podcastId,
    @Property(type: PropertyType.dateNano) required DateTime date,
    required String name,
    @JsonKey(name: 'img_path') @Default("") String imgPath,
    @JsonKey(name: 'podcast_duration') @Default(0.0) double episodeDuration,
    @JsonKey(name: 'has_podcast') required bool hasPodcast,
    @Default(false) bool isFavorited,
    @Backlink('episode')
    @JsonKey(fromJson: _historyItemFromJson)
    required ToMany<HistoryItem> history,
    @Default(0.0) double progress,
  }) = _Episode;

  factory Episode.fromJson(Map<String, Object?> json) =>
      _$EpisodeFromJson(json);

  /// Gets the title of the episode.
  String get getEpisodeTitle {
    String episodeTitle = "$name - ${DateFormat("yyyy-MM-dd").format(date)}";

    return episodeTitle;
  }

  /// Gets the readable duration of the episode.
  String get getReadableDuration {
    if (episodeDuration == 0.0) {
      return "Unknown duration";
    }

    int totalSeconds = episodeDuration.toInt();
    int minutes = (totalSeconds / 60).round();

    return "$minutes min";
  }

  /// Gets the URL for a specific episode.
  String get getEpisodeUrl => '${Const.mainUrl}/podcast/$episodeId';
}

ToMany<HistoryItem> _historyItemFromJson(List<dynamic>? jsonList) => ToMany();
