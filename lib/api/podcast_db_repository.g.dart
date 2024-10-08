// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_db_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$podcastListHash() => r'68b542b248be5d3661934111f6e0f95be9a136a0';

/// See also [podcastList].
@ProviderFor(podcastList)
final podcastListProvider = AutoDisposeFutureProvider<List<PodcastDB>>.internal(
  podcastList,
  name: r'podcastListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$podcastListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PodcastListRef = AutoDisposeFutureProviderRef<List<PodcastDB>>;
String _$favoritedPodcastsHash() => r'a020a9fb33022ce863f1e64e33a3ee892d9ce8f9';

/// Fetches all favorited podcasts from the database.
///
/// Copied from [FavoritedPodcasts].
@ProviderFor(FavoritedPodcasts)
final favoritedPodcastsProvider = AutoDisposeAsyncNotifierProvider<
    FavoritedPodcasts, List<PodcastDB>>.internal(
  FavoritedPodcasts.new,
  name: r'favoritedPodcastsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritedPodcastsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavoritedPodcasts = AutoDisposeAsyncNotifier<List<PodcastDB>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
