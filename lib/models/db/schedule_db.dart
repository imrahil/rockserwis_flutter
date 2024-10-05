import 'package:objectbox/objectbox.dart';
import 'package:rockserwis_podcaster/models/schedule.dart';

@Entity()
class ScheduleDB {
  int id = 0;
  int? weekday;
  String? start;
  String? end;

  // Static factory method
  static ScheduleDB createItem({
    int? weekday,
    String? start,
    String? end,
  }) {
    final schedule = ScheduleDB();

    schedule.weekday = weekday;
    schedule.start = start;
    schedule.end = end;

    return schedule;
  }

  // Method to convert Schedule to ScheduleDB
  static ScheduleDB fromSchedule(Schedule schedule) {
    return ScheduleDB.createItem(
      weekday: schedule.weekday,
      start: schedule.start,
      end: schedule.end,
    );
  }
}
