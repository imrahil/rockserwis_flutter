// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      (json['schedule_id'] as num).toInt(),
      DateTime.parse(json['date'] as String),
      json['name'] as String,
      json['img_path'] as String?,
      (json['podcast_duration'] as num?)?.toDouble(),
      json['has_podcast'] as bool,
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'schedule_id': instance.episodeId,
      'date': instance.date.toIso8601String(),
      'name': instance.name,
      'img_path': instance.imgPath,
      'podcast_duration': instance.episodeDuration,
      'has_podcast': instance.hasPodcast,
    };
