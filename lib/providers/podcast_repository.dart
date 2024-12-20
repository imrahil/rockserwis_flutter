import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/data/missing_podcasts.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/providers/objectbox_repository.dart';
import 'package:rockserwis_podcaster/utils/const.dart';

part 'podcast_repository.g.dart';

class PodcastJsonRepository {
  PodcastJsonRepository({required this.client});

  final http.Client client;

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
PodcastJsonRepository podcastRepository(Ref ref) {
  return PodcastJsonRepository(
    client: http.Client(),
  );
}

@riverpod
Future<List<Podcast>> fetchPodcasts(Ref ref) {
  return ref.watch(podcastRepositoryProvider).fetchPodcasts();
}

@riverpod
class AllPodcasts extends _$AllPodcasts {
  @override
  Future<List<Podcast>> build() async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    return objectBox.podcastBox.getAllAsync();
  }

  Future<void> toggleFavoritePodcast(Podcast podcast) async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    final updatedPodcast = podcast.copyWith(isFavorited: !podcast.isFavorited);
    await objectBox.podcastBox.putAsync(updatedPodcast);

    await update((previousState) => [
          ...previousState.map(
            (podcast) =>
                podcast.id == updatedPodcast.id ? updatedPodcast : podcast,
          )
        ]);
  }
}

@riverpod
Future<List<Podcast>> favoritedPodcasts(Ref ref) async {
  final allPodcastsList = await ref.watch(allPodcastsProvider.future);

  final favorites =
      allPodcastsList.where((podcast) => podcast.isFavorited).toList();

  favorites.sort((a, b) => a.podcastName.compareTo(b.podcastName));

  return favorites;
}
