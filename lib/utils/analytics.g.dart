// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(analytics)
final analyticsProvider = AnalyticsProvider._();

final class AnalyticsProvider
    extends $FunctionalProvider<AppAnalytics, AppAnalytics, AppAnalytics>
    with $Provider<AppAnalytics> {
  AnalyticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsHash();

  @$internal
  @override
  $ProviderElement<AppAnalytics> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppAnalytics create(Ref ref) {
    return analytics(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppAnalytics value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppAnalytics>(value),
    );
  }
}

String _$analyticsHash() => r'a1ddfee52637a9ae3b57936c3535f66fbd2be1bd';
