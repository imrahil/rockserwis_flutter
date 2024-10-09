import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:rockserwis_podcaster/models/author.dart';
import 'package:rockserwis_podcaster/models/schedule.dart';

part 'podcast.freezed.dart';
part 'podcast.g.dart';

@Freezed(toJson: false, addImplicitFinal: false)
class Podcast with _$Podcast {
  @Entity(realClass: Podcast)
  @JsonSerializable(createToJson: false)
  factory Podcast({
    @Id() @Default(0) int id,
    @JsonKey(name: 'broadcast_id') required int podcastId,
    @JsonKey(name: 'broadcast_name') required String podcastName,
    @JsonKey(name: 'broadcast_broadcasters', fromJson: _authorsFromJson)
    required ToMany<Author> authors,
    @JsonKey(name: 'broadcast_times', fromJson: _schedulesFromJson)
    required ToMany<Schedule> schedules,
    @JsonKey(name: 'music_only') required bool onlyMusic,
    @JsonKey(name: 'podcasts_active') required bool isActive,
    @JsonKey(name: 'has_podcasts') required bool hasEpisodes,
    @Default("") String image,
    @Default(false) bool isFavorited,
  }) = _Podcast;

  factory Podcast.fromJson(Map<String, Object?> json) =>
      _$PodcastFromJson(json);
}

List<T> readJsonList<T>(List<dynamic> jsonList,
    {required T Function(Map<String, dynamic>) mapper}) {
  return [for (final json in jsonList) mapper(json)];
}

ToMany<Author> _authorsFromJson(List<dynamic> jsonList) {
  return ToMany(items: readJsonList(jsonList, mapper: Author.fromJson));
}

ToMany<Schedule> _schedulesFromJson(List<dynamic> jsonList) {
  return ToMany(items: readJsonList(jsonList, mapper: Schedule.fromJson));
}
