// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PodcastImpl _$$PodcastImplFromJson(Map<String, dynamic> json) =>
    _$PodcastImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      podcastId: (json['broadcast_id'] as num).toInt(),
      podcastName: json['broadcast_name'] as String,
      authors: _authorsFromJson(json['broadcast_broadcasters'] as List),
      schedules: _schedulesFromJson(json['broadcast_times'] as List),
      onlyMusic: json['music_only'] as bool,
      isActive: json['podcasts_active'] as bool,
      hasEpisodes: json['has_podcasts'] as bool,
      image: json['image'] as String?,
      isFavorited: json['isFavorited'] as bool? ?? false,
    );
