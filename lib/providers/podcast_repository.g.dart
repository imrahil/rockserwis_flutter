// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(podcastRepository)
final podcastRepositoryProvider = PodcastRepositoryProvider._();

final class PodcastRepositoryProvider
    extends
        $FunctionalProvider<
          PodcastJsonRepository,
          PodcastJsonRepository,
          PodcastJsonRepository
        >
    with $Provider<PodcastJsonRepository> {
  PodcastRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'podcastRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$podcastRepositoryHash();

  @$internal
  @override
  $ProviderElement<PodcastJsonRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PodcastJsonRepository create(Ref ref) {
    return podcastRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PodcastJsonRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PodcastJsonRepository>(value),
    );
  }
}

String _$podcastRepositoryHash() => r'e75ebd53b832a0dc7107c1eac64f8e44559fee4f';

@ProviderFor(fetchPodcasts)
final fetchPodcastsProvider = FetchPodcastsProvider._();

final class FetchPodcastsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Podcast>>,
          List<Podcast>,
          FutureOr<List<Podcast>>
        >
    with $FutureModifier<List<Podcast>>, $FutureProvider<List<Podcast>> {
  FetchPodcastsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchPodcastsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchPodcastsHash();

  @$internal
  @override
  $FutureProviderElement<List<Podcast>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Podcast>> create(Ref ref) {
    return fetchPodcasts(ref);
  }
}

String _$fetchPodcastsHash() => r'087ad5e3daad76214b7d1427c91f0940fc0c7de6';

@ProviderFor(AllPodcasts)
final allPodcastsProvider = AllPodcastsProvider._();

final class AllPodcastsProvider
    extends $AsyncNotifierProvider<AllPodcasts, List<Podcast>> {
  AllPodcastsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allPodcastsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allPodcastsHash();

  @$internal
  @override
  AllPodcasts create() => AllPodcasts();
}

String _$allPodcastsHash() => r'cb37183afda3a1a4f9ba5c042a660d1b7853d554';

abstract class _$AllPodcasts extends $AsyncNotifier<List<Podcast>> {
  FutureOr<List<Podcast>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Podcast>>, List<Podcast>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Podcast>>, List<Podcast>>,
              AsyncValue<List<Podcast>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(favoritedPodcasts)
final favoritedPodcastsProvider = FavoritedPodcastsProvider._();

final class FavoritedPodcastsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Podcast>>,
          List<Podcast>,
          FutureOr<List<Podcast>>
        >
    with $FutureModifier<List<Podcast>>, $FutureProvider<List<Podcast>> {
  FavoritedPodcastsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritedPodcastsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritedPodcastsHash();

  @$internal
  @override
  $FutureProviderElement<List<Podcast>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Podcast>> create(Ref ref) {
    return favoritedPodcasts(ref);
  }
}

String _$favoritedPodcastsHash() => r'8e9b3bb1eb06bdb26fe4c84febe045fa515e452f';
