// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_sync_helper.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(podcastSyncHelper)
final podcastSyncHelperProvider = PodcastSyncHelperProvider._();

final class PodcastSyncHelperProvider
    extends
        $FunctionalProvider<
          PodcastSyncHelper,
          PodcastSyncHelper,
          PodcastSyncHelper
        >
    with $Provider<PodcastSyncHelper> {
  PodcastSyncHelperProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'podcastSyncHelperProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$podcastSyncHelperHash();

  @$internal
  @override
  $ProviderElement<PodcastSyncHelper> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PodcastSyncHelper create(Ref ref) {
    return podcastSyncHelper(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PodcastSyncHelper value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PodcastSyncHelper>(value),
    );
  }
}

String _$podcastSyncHelperHash() => r'471c8ed25dc0706ea4a98288a0d29c602242b4dc';
