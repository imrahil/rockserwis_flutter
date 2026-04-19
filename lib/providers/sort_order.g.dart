// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_order.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SortOrder)
final sortOrderProvider = SortOrderProvider._();

final class SortOrderProvider
    extends $NotifierProvider<SortOrder, SortOrderType> {
  SortOrderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortOrderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortOrderHash();

  @$internal
  @override
  SortOrder create() => SortOrder();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SortOrderType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SortOrderType>(value),
    );
  }
}

String _$sortOrderHash() => r'238b184209ddbddc6a067f59f0849176b0dff6d9';

abstract class _$SortOrder extends $Notifier<SortOrderType> {
  SortOrderType build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SortOrderType, SortOrderType>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SortOrderType, SortOrderType>,
              SortOrderType,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
