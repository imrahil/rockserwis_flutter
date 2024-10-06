// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$podcastRepositoryHash() => r'24ad026d7848b718815990e7ce8a22c4372141ff';

/// See also [podcastRepository].
@ProviderFor(podcastRepository)
final podcastRepositoryProvider =
    AutoDisposeProvider<PodcastRepository>.internal(
  podcastRepository,
  name: r'podcastRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$podcastRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PodcastRepositoryRef = AutoDisposeProviderRef<PodcastRepository>;
String _$fetchPodcastsHash() => r'a05557c9a901ecda762c8fb5fe70c6b3acdc82cb';

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

typedef FetchPodcastsRef = AutoDisposeFutureProviderRef<List<Podcast>>;
String _$fetchFavoritedPodcastsHash() =>
    r'a9e59dc6a90cb8017ba270d113ea3af8f0644239';

/// See also [fetchFavoritedPodcasts].
@ProviderFor(fetchFavoritedPodcasts)
final fetchFavoritedPodcastsProvider =
    AutoDisposeFutureProvider<List<Podcast>>.internal(
  fetchFavoritedPodcasts,
  name: r'fetchFavoritedPodcastsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchFavoritedPodcastsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchFavoritedPodcastsRef = AutoDisposeFutureProviderRef<List<Podcast>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
