import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/api_new.dart';
import 'package:rockserwis_podcaster/api/data/missing_podcasts.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'podcast_repository.g.dart';

class PodcastRepository {
  PodcastRepository(
      {required this.apiRepository, required this.sharedPreferences});

  final ApiRepository apiRepository;
  final SharedPreferences sharedPreferences;

  static const String favoritePodcastsKey = 'favoritePodcasts';

  /// Fetches and caches JSON data for all podcasts.
  ///
  /// @param forceRefresh Whether to force a refresh from the network, even if data is in the cache.
  /// @return A list of all podcasts.
  Future<List<Podcast>> fetchPodcasts({bool forceRefresh = false}) async {
    return await apiRepository.fetchAndCacheJson(ApiRepository.broadCastUrl,
        (jsonData) {
      List<Podcast> podcasts = (json.decode(jsonData) as List)
          .map((i) => Podcast.fromJson(i))
          .toList();

      List<Podcast> missingPodcastsParsed =
          missingPodcasts.map((podcast) => Podcast.fromJson(podcast)).toList();

      List<Podcast> output = [...podcasts, ...missingPodcastsParsed];
      output.sort((a, b) => a.podcastName.compareTo(b.podcastName));

      return output;
    }, forceRefresh: forceRefresh);
  }

  /// Gets the list of favorite podcasts from SharedPreferences.
  ///
  /// @return A list of favorite podcasts.
  Future<List<Podcast>> fetchFavoritedPodcasts() async {
    List<String> favoritePodcasts =
        sharedPreferences.getStringList(favoritePodcastsKey) ?? [];

    return favoritePodcasts.map((podcastString) {
      final podcastJson = jsonDecode(podcastString);
      return Podcast.fromJson(podcastJson);
    }).toList();
  }
}

@riverpod
PodcastRepository podcastRepository(PodcastRepositoryRef ref) {
  return PodcastRepository(
    apiRepository: ref.watch(apiRepositoryProvider),
    sharedPreferences: ref.watch(sharedPreferencesProvider).requireValue,
  );
}

@riverpod
Future<List<Podcast>> fetchPodcasts(FetchPodcastsRef ref) {
  return ref.watch(podcastRepositoryProvider).fetchPodcasts();
}

@riverpod
Future<List<Podcast>> fetchFavoritedPodcasts(FetchFavoritedPodcastsRef ref) {
  return ref.watch(podcastRepositoryProvider).fetchFavoritedPodcasts();
}
