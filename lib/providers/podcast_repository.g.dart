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
String _$podcastListHash() => r'2c634708a01a45b0c087b0e824c562e977ce32ce';

/// See also [podcastList].
@ProviderFor(podcastList)
final podcastListProvider = AutoDisposeFutureProvider<List<Podcast>>.internal(
  podcastList,
  name: r'podcastListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$podcastListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PodcastListRef = AutoDisposeFutureProviderRef<List<Podcast>>;
String _$favoritedPodcastsHash() => r'dfc2e0ba57329d07402fbd0aeb6bb3966c758c71';

/// Fetches all favorited podcasts from the database.
///
/// Copied from [FavoritedPodcasts].
@ProviderFor(FavoritedPodcasts)
final favoritedPodcastsProvider =
    AutoDisposeAsyncNotifierProvider<FavoritedPodcasts, List<Podcast>>.internal(
  FavoritedPodcasts.new,
  name: r'favoritedPodcastsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritedPodcastsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavoritedPodcasts = AutoDisposeAsyncNotifier<List<Podcast>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member