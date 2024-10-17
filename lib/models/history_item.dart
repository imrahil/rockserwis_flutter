import 'package:objectbox/objectbox.dart';
import 'package:rockserwis_podcaster/models/episode.dart';

@Entity()
class HistoryItem {
  @Id()
  int id = 0;
  @Property(type: PropertyType.dateNano)
  DateTime date;
  final episode = ToOne<Episode>();

  HistoryItem({this.id = 0, DateTime? date}) : date = date ?? DateTime.now();
}
