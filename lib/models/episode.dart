import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  @JsonKey(name: 'schedule_id')
  final int episodeId;

  final DateTime date;
  final String name;

  @JsonKey(name: 'img_path')
  final String? imgPath;

  @JsonKey(name: 'podcast_duration')
  final double? episodeDuration;

  @JsonKey(name: 'has_podcast')
  final bool hasPodcast;

  Episode(this.episodeId, this.date, this.name, this.imgPath,
      this.episodeDuration, this.hasPodcast);

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  String getReadableDuration() {
    if (episodeDuration == null) {
      return "Unknown duration";
    }

    int totalSeconds = episodeDuration!.toInt();
    int minutes = (totalSeconds / 60).round();

    return "$minutes min";
  }
}
