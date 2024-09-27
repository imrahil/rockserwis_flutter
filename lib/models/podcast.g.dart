// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Podcast _$PodcastFromJson(Map<String, dynamic> json) => Podcast(
      podcastId: (json['broadcast_id'] as num).toInt(),
      podcastName: json['broadcast_name'] as String,
      authors: (json['broadcast_broadcasters'] as List<dynamic>)
          .map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      schedules: (json['broadcast_times'] as List<dynamic>)
          .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      onlyMusic: json['music_only'] as bool,
      isActive: json['podcasts_active'] as bool,
      hasEpisodes: json['has_podcasts'] as bool,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$PodcastToJson(Podcast instance) => <String, dynamic>{
      'broadcast_id': instance.podcastId,
      'broadcast_name': instance.podcastName,
      'broadcast_broadcasters': instance.authors,
      'broadcast_times': instance.schedules,
      'music_only': instance.onlyMusic,
      'podcasts_active': instance.isActive,
      'has_podcasts': instance.hasEpisodes,
      'image': instance.image,
    };
