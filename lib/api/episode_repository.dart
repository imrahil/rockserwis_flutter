import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/api.dart';
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

  /// Toggles the favorite status of an episode.
  ///
  /// @param episode The episode to toggle the favorite status of.
  Future<void> toggleFavoriteEpisode(Episode episode) async {
    // Get current favorites from SharedPreferences
    List<String> favoriteEpisodes =
        sharedPreferences.getStringList(favoriteEpisodesKey) ?? [];

    final episodeString = jsonEncode(episode);

    // Toggle favorite status
    if (favoriteEpisodes.contains(episodeString)) {
      favoriteEpisodes.remove(episodeString);
    } else {
      favoriteEpisodes.add(episodeString);
    }

    // Save updated favorites back to SharedPreferences
    await sharedPreferences.setStringList(
        favoriteEpisodesKey, favoriteEpisodes);
  }

  /// Checks if an episode is a favorite.
  ///
  /// @param episode The episode to check.
  /// @return True if the episode is a favorite, false otherwise.
  bool isFavoriteEpisode(Episode episode) {
    List<String> favoriteEpisodes =
        sharedPreferences.getStringList(favoriteEpisodesKey) ?? [];

    final episodeIdString = jsonEncode(episode);

    return favoriteEpisodes.contains(episodeIdString);
  }

  /// Helper function to get the previous episode in the list
  Episode? getPreviousEpisode(int currentEpisodeId) {
    final currentIndex = _selectedPodcastEpisodes
        .indexWhere((episode) => episode.episodeId == currentEpisodeId);

    if (currentIndex > 0 && currentIndex < _selectedPodcastEpisodes.length) {
      return _selectedPodcastEpisodes[currentIndex - 1];
    } else {
      return null;
    }
  }

  /// Helper function to get the next episode in the list
  Episode? getNextEpisode(int currentEpisodeId) {
    final currentIndex = _selectedPodcastEpisodes
        .indexWhere((episode) => episode.episodeId == currentEpisodeId);

    if (currentIndex >= 0 &&
        currentIndex < _selectedPodcastEpisodes.length - 1) {
      return _selectedPodcastEpisodes[currentIndex + 1];
    } else {
      return null;
    }
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
