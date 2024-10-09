import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/const.dart';
import 'package:rockserwis_podcaster/api/data/missing_podcasts.dart';
import 'package:rockserwis_podcaster/api/objectbox_repository.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/objectbox.g.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'podcast_repository.g.dart';

class PodcastJsonRepository {
  PodcastJsonRepository(
      {required this.client, required this.sharedPreferences});

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
}

@riverpod
PodcastJsonRepository podcastRepository(PodcastRepositoryRef ref) {
  return PodcastJsonRepository(
    client: http.Client(),
    sharedPreferences: ref.watch(sharedPreferencesProvider).requireValue,
  );
}

@riverpod
Future<List<Podcast>> fetchPodcasts(FetchPodcastsRef ref) {
  return ref.watch(podcastRepositoryProvider).fetchPodcasts();
}

@riverpod
Future<List<Podcast>> podcastList(PodcastListRef ref) async {
  final objectBox = await ref.watch(objectBoxProvider.future);

  return objectBox.podcastBox.getAllAsync();
}

/// Fetches all favorited podcasts from the database.
@riverpod
class FavoritedPodcasts extends _$FavoritedPodcasts {
  @override
  Future<List<Podcast>> build() async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    return objectBox.podcastBox
        .query(Podcast_.isFavorited.equals(true))
        .build()
        .findAsync();
  }

  /// Toggles the favorite status of an podcast.
  ///
  /// @param podcast The episode to toggle the favorite status of.
  Future<void> toggleFavoritePodcast(Podcast podcast) async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    final updatedPodcast = podcast.copyWith(isFavorited: !podcast.isFavorited);
    await objectBox.podcastBox.putAsync(updatedPodcast);

    ref.invalidateSelf();
    await future;
  }
}
