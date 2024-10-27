// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$podcastRepositoryHash() => r'42df5432089adf9068df2c92c6d289cc23ec736b';

/// See also [podcastRepository].
@ProviderFor(podcastRepository)
final podcastRepositoryProvider =
    AutoDisposeProvider<PodcastJsonRepository>.internal(
  podcastRepository,
  name: r'podcastRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$podcastRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PodcastRepositoryRef = AutoDisposeProviderRef<PodcastJsonRepository>;
String _$fetchPodcastsHash() => r'087ad5e3daad76214b7d1427c91f0940fc0c7de6';

/// See also [fetchPodcasts].
@ProviderFor(fetchPodcasts)
final fetchPodcastsProvider = AutoDisposeFutureProvider<List<Podcast>>.internal(
  fetchPodcasts,
  name: r'fetchPodcastsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchPodcastsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchPodcastsRef = AutoDisposeFutureProviderRef<List<Podcast>>;
String _$favoritedPodcastsHash() => r'8e9b3bb1eb06bdb26fe4c84febe045fa515e452f';

/// See also [favoritedPodcasts].
@ProviderFor(favoritedPodcasts)
final favoritedPodcastsProvider =
    AutoDisposeFutureProvider<List<Podcast>>.internal(
  favoritedPodcasts,
  name: r'favoritedPodcastsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritedPodcastsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoritedPodcastsRef = AutoDisposeFutureProviderRef<List<Podcast>>;
String _$allPodcastsHash() => r'cb37183afda3a1a4f9ba5c042a660d1b7853d554';

/// See also [AllPodcasts].
@ProviderFor(AllPodcasts)
final allPodcastsProvider =
    AutoDisposeAsyncNotifierProvider<AllPodcasts, List<Podcast>>.internal(
  AllPodcasts.new,
  name: r'allPodcastsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allPodcastsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AllPodcasts = AutoDisposeAsyncNotifier<List<Podcast>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
