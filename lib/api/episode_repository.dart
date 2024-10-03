import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/api_new.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'episode_repository.g.dart';

class EpisodeRepository {
  EpisodeRepository(
      {required this.apiRepository, required this.sharedPreferences});

  final ApiRepository apiRepository;
  final SharedPreferences sharedPreferences;

  static const String favoriteEpisodesKey = 'favoriteEpisodes';

  List<Episode> _selectedPodcastEpisodes = [];

  /// Fetches and caches JSON data for episodes of a specific podcast.
  ///
  /// @param currentPodcast The podcast to fetch episodes for.
  /// @param forceRefresh Whether to force a refresh from the network, even if data is in the cache.
  /// @return A list of episodes for the given podcast.
  Future<List<Episode>> fetchEpisodes(Podcast currentPodcast,
      {bool forceRefresh = false}) async {
    String url =
        '${ApiRepository.scheduleUrl}/${currentPodcast.podcastId}.json';

    return await apiRepository.fetchAndCacheJson(url, (jsonData) {
      _selectedPodcastEpisodes = (json.decode(jsonData) as List)
          .map((i) => Episode.fromJson(i))
          .where((episode) => episode.hasPodcast)
          .toList();

      return _selectedPodcastEpisodes;
    }, forceRefresh: forceRefresh);
  }

  /// Gets the list of favorite episodes from SharedPreferences.
  ///
  /// @return A list of favorite episodes.
  Future<List<Episode>> fetchFavoritedEpisodes() async {
    List<String> favoriteEpisodes =
        sharedPreferences.getStringList(favoriteEpisodesKey) ?? [];

    _selectedPodcastEpisodes = favoriteEpisodes.map((episodeString) {
      final episodeJson = jsonDecode(episodeString);
      return Episode.fromJson(episodeJson);
    }).toList();

    return _selectedPodcastEpisodes;
  }
}

@riverpod
EpisodeRepository episodeRepository(EpisodeRepositoryRef ref) {
  return EpisodeRepository(
    apiRepository: ref.watch(apiRepositoryProvider),
    sharedPreferences: ref.watch(sharedPreferencesProvider).requireValue,
  );
}

@riverpod
Future<List<Episode>> fetchEpisodes(
    FetchEpisodesRef ref, Podcast currentPodcast) {
  return ref.watch(episodeRepositoryProvider).fetchEpisodes(currentPodcast);
}

@riverpod
Future<List<Episode>> fetchFavoritedEpisodes(FetchFavoritedEpisodesRef ref) {
  return ref.watch(episodeRepositoryProvider).fetchFavoritedEpisodes();
}
