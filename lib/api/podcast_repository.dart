import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/const.dart';
import 'package:rockserwis_podcaster/api/data/missing_podcasts.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'podcast_repository.g.dart';

class PodcastRepository {
  PodcastRepository({required this.client, required this.sharedPreferences});

  final http.Client client;
  final SharedPreferences sharedPreferences;

  /// Fetches and caches JSON data for all podcasts.
  ///
  /// @return A list of all podcasts.
  Future<List<Podcast>> fetchPodcasts() async {
    final response = await client.get(Uri.parse(Const.broadCastUrl));

    if (response.statusCode == 200) {
      List<Podcast> podcasts = (json.decode(response.body) as List)
          .map((i) => Podcast.fromJson(i))
          .toList();

      List<Podcast> missingPodcastsParsed =
          missingPodcasts.map((podcast) => Podcast.fromJson(podcast)).toList();

      List<Podcast> output = [...podcasts, ...missingPodcastsParsed];
      output.sort((a, b) => a.podcastName.compareTo(b.podcastName));

      return output;
    } else {
      throw Exception('Failed to load podcasts!');
    }
  }

  /// Gets the list of favorite podcasts from SharedPreferences.
  ///
  /// @return A list of favorite podcasts.
  Future<List<Podcast>> fetchFavoritedPodcasts() async {
    List<String> favoritePodcasts =
        sharedPreferences.getStringList(Const.favoritePodcastsKey) ?? [];

    return favoritePodcasts.map((podcastString) {
      final podcastJson = jsonDecode(podcastString);
      return Podcast.fromJson(podcastJson);
    }).toList();
  }

  /// Toggles the favorite status of an podcast.
  ///
  /// @param podcast The episode to toggle the favorite status of.
  Future<void> toggleFavoritePodcast(Podcast podcast) async {
    // Get current favorites from SharedPreferences
    List<String> favoritePodcasts =
        sharedPreferences.getStringList(Const.favoritePodcastsKey) ?? [];

    final podcastString = jsonEncode(podcast);

    // Toggle favorite status
    if (favoritePodcasts.contains(podcastString)) {
      favoritePodcasts.remove(podcastString);
    } else {
      favoritePodcasts.add(podcastString);
    }

    // Save updated favorites back to SharedPreferences
    await sharedPreferences.setStringList(
        Const.favoritePodcastsKey, favoritePodcasts);
  }

  /// Checks if a podcast is a favorite.
  ///
  /// @param podcast The podcast to check.
  /// @return True if the podcast is a favorite, false otherwise.
  bool isFavoritePodcast(Podcast podcast) {
    List<String> favoritePodcasts =
        sharedPreferences.getStringList(Const.favoritePodcastsKey) ?? [];

    final podcastIdString = jsonEncode(podcast);

    return favoritePodcasts.contains(podcastIdString);
  }
}

@riverpod
PodcastRepository podcastRepository(PodcastRepositoryRef ref) {
  return PodcastRepository(
    client: http.Client(),
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
