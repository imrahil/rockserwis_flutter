// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DownloadSettingsNotifier)
final downloadSettingsProvider = DownloadSettingsNotifierProvider._();

final class DownloadSettingsNotifierProvider
    extends $NotifierProvider<DownloadSettingsNotifier, DownloadSettings> {
  DownloadSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadSettingsNotifierHash();

  @$internal
  @override
  DownloadSettingsNotifier create() => DownloadSettingsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DownloadSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DownloadSettings>(value),
    );
  }
}

String _$downloadSettingsNotifierHash() =>
    r'8e26accd4b2b406f8032b00a77aa35b77212ebf1';

abstract class _$DownloadSettingsNotifier extends $Notifier<DownloadSettings> {
  DownloadSettings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DownloadSettings, DownloadSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DownloadSettings, DownloadSettings>,
              DownloadSettings,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
