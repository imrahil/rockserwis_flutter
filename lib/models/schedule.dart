import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'schedule.freezed.dart';
part 'schedule.g.dart';

@Freezed(addImplicitFinal: false)
class Schedule with _$Schedule {
  @Entity(realClass: Schedule)
  factory Schedule({
    @Id() @Default(0) int id,
    required int weekday,
    required String start,
    required String end,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}
