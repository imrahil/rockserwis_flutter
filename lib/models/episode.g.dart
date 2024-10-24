// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EpisodeImpl _$$EpisodeImplFromJson(Map<String, dynamic> json) =>
    _$EpisodeImpl(
      id: (json['id'] as num?)?.toInt() ?? 0,
      episodeId: (json['schedule_id'] as num).toInt(),
      podcastId: (json['podcastId'] as num?)?.toInt(),
      date: DateTime.parse(json['date'] as String),
      name: json['name'] as String,
      imgPath: json['img_path'] as String? ?? "",
      episodeDuration: (json['podcast_duration'] as num?)?.toDouble() ?? 0.0,
      hasPodcast: json['has_podcast'] as bool,
      isFavorited: json['isFavorited'] as bool? ?? false,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      progress: (json['progress'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
    );
