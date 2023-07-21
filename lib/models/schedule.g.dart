// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      json['schedule_id'] as int,
      DateTime.parse(json['date'] as String),
      json['name'] as String,
      json['img_path'] as String?,
      (json['podcast_duration'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'schedule_id': instance.scheduleId,
      'date': instance.date.toIso8601String(),
      'name': instance.name,
      'img_path': instance.imgPath,
      'podcast_duration': instance.podcastDuration,
    };
