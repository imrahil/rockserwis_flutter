// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Schedule _$ScheduleFromJson(Map<String, dynamic> json) => _Schedule(
      id: (json['id'] as num?)?.toInt() ?? 0,
      weekday: (json['weekday'] as num).toInt(),
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$ScheduleToJson(_Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'weekday': instance.weekday,
      'start': instance.start,
      'end': instance.end,
    };
