// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      weekday: (json['weekday'] as num).toInt(),
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'weekday': instance.weekday,
      'start': instance.start,
      'end': instance.end,
    };
