// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$podcastRepositoryHash() => r'd729744ec2a1bc281142889d82ea00330bef2bb6';

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

typedef PodcastRepositoryRef = AutoDisposeProviderRef<PodcastJsonRepository>;
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
String _$favoritedPodcastsHash() => r'056e88c82c76314cab740a55c808d180350e67a5';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
