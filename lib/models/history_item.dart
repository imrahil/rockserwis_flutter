import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:rockserwis_podcaster/models/episode.dart';

part 'history_item.freezed.dart';

@Freezed(addImplicitFinal: false)
class HistoryItem with _$HistoryItem {
  @Entity(realClass: HistoryItem)
  factory HistoryItem({
    @Id() @Default(0) int id,
    @Property(type: PropertyType.dateNano) required DateTime date,
    required ToOne<Episode> episode,
  }) = _HistoryItem;
}
