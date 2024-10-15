import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sort_order.g.dart';

enum SortOrderType { ascending, descending }

@Riverpod(keepAlive: true)
class SortOrder extends _$SortOrder {
  @override
  SortOrderType build() {
    return SortOrderType.descending;
  }

  SortOrderType change() {
    state = state == SortOrderType.ascending
        ? SortOrderType.descending
        : SortOrderType.ascending;

    return state;
  }
}
