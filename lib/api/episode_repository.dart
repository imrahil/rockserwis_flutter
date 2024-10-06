import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/const.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'episode_repository.g.dart';

class EpisodeRepository {
  EpisodeRepository({required this.client, required this.sharedPreferences});

  final http.Client client;
  final SharedPreferences sharedPreferences;

  static const String favoriteEpisodesKey = 'favoriteEpisodes';

  List<Episode> _selectedPodcastEpisodes = [];

  /// Fetches and caches JSON data for episodes of a specific podcast.
  ///
  /// @param podcastId The id of the podcast to fetch episodes for.
  /// @return A list of episodes for the given podcast.
  Future<List<Episode>> fetchEpisodes(int podcastId) async {
    String url = '${Const.scheduleUrl}/$podcastId.json';

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      _selectedPodcastEpisodes = (json.decode(response.body) as List)
          .map((i) => Episode.fromJson(i))
          .where((episode) => episode.hasPodcast)
          .toList();

      return _selectedPodcastEpisodes;
    } else {
      throw Exception('Failed to load data from: $url');
    }
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

  /// Gets the URL for a specific episode.
  ///
  /// @param episodeId The ID of the episode.
  /// @return The URL for the episode.
  String getEpisodeUrl(int episodeId) => '${Const.mainUrl}/podcast/$episodeId';
}

@riverpod
EpisodeRepository episodeRepository(EpisodeRepositoryRef ref) {
  return EpisodeRepository(
    client: http.Client(),
    sharedPreferences: ref.watch(sharedPreferencesProvider).requireValue,
  );
}

@riverpod
Future<List<Episode>> fetchEpisodes(FetchEpisodesRef ref, int podcastId) {
  return ref.watch(episodeRepositoryProvider).fetchEpisodes(podcastId);
}

@riverpod
Future<List<Episode>> fetchFavoritedEpisodes(FetchFavoritedEpisodesRef ref) {
  return ref.watch(episodeRepositoryProvider).fetchFavoritedEpisodes();
}
