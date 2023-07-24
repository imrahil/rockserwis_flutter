// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Podcast _$PodcastFromJson(Map<String, dynamic> json) => Podcast(
      podcastId: json['broadcast_id'] as int,
      podcastName: json['broadcast_name'] as String,
      hasEpisodes: json['has_podcasts'] as bool,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$PodcastToJson(Podcast instance) => <String, dynamic>{
      'broadcast_id': instance.podcastId,
      'broadcast_name': instance.podcastName,
      'image': instance.image,
      'has_podcasts': instance.hasEpisodes,
    };
