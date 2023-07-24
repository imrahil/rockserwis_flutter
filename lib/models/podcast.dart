import 'package:json_annotation/json_annotation.dart';

part 'podcast.g.dart';

@JsonSerializable()
class Podcast {
    @JsonKey(name: 'broadcast_id')
    final int podcastId;

    @JsonKey(name: 'broadcast_name')
    final String podcastName;

    final String? image;

    @JsonKey(name: 'has_podcasts')
    final bool hasEpisodes;

    Podcast({required this.podcastId, required this.podcastName, required this.hasEpisodes, required this.image});

    factory Podcast.fromJson(Map<String, dynamic> json) => _$PodcastFromJson(json);

    Map<String, dynamic> toJson() => _$PodcastToJson(this);
}