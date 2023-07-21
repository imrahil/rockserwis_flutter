import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  @JsonKey(name: 'schedule_id')
  final int scheduleId;

  final DateTime date;
  final String name;

  @JsonKey(name: 'img_path')
  final String? imgPath;

  @JsonKey(name: 'podcast_duration')
  final double? podcastDuration;

  Schedule(this.scheduleId, this.date, this.name, this.imgPath, this.podcastDuration);

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
