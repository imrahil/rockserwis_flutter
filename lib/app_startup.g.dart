// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_startup.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppStartupNotifier)
final appStartupProvider = AppStartupNotifierProvider._();

final class AppStartupNotifierProvider
    extends $AsyncNotifierProvider<AppStartupNotifier, void> {
  AppStartupNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appStartupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appStartupNotifierHash();

  @$internal
  @override
  AppStartupNotifier create() => AppStartupNotifier();
}

String _$appStartupNotifierHash() =>
    r'e1dbf83db178a09e11b250d16115626917ba68f8';

abstract class _$AppStartupNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
