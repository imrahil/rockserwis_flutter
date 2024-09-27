import 'package:json_annotation/json_annotation.dart';
import 'package:rockserwis_podcaster/models/author.dart';
import 'package:rockserwis_podcaster/models/schedule.dart';

part 'podcast.g.dart';

@JsonSerializable()
class Podcast {
  @JsonKey(name: 'broadcast_id')
  final int podcastId;

  @JsonKey(name: 'broadcast_name')
  final String podcastName;

  @JsonKey(name: 'broadcast_broadcasters')
  final List<Author> authors;

  @JsonKey(name: 'broadcast_times')
  final List<Schedule> schedules;

  @JsonKey(name: 'music_only')
  final bool onlyMusic;

  @JsonKey(name: 'podcasts_active')
  final bool isActive;

  @JsonKey(name: 'has_podcasts')
  final bool hasEpisodes;

  final String? image;

  Podcast({
    required this.podcastId,
    required this.podcastName,
    required this.authors,
    required this.schedules,
    required this.onlyMusic,
    required this.isActive,
    required this.hasEpisodes,
    this.image,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) =>
      _$PodcastFromJson(json);

  Map<String, dynamic> toJson() => _$PodcastToJson(this);
}
