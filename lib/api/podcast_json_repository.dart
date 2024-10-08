import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/const.dart';
import 'package:rockserwis_podcaster/api/data/missing_podcasts.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'podcast_json_repository.g.dart';

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
