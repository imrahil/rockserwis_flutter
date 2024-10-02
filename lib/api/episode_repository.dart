import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/api_new.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';

part 'episode_repository.g.dart';

class EpisodeRepository {
  EpisodeRepository({required this.apiRepository});

  final ApiRepository apiRepository;

  List<Episode> selectedPodcastEpisodes = [];

  /// Fetches and caches JSON data for episodes of a specific podcast.
  ///
  /// @param currentPodcast The podcast to fetch episodes for.
  /// @param forceRefresh Whether to force a refresh from the network, even if data is in the cache.
  /// @return A list of episodes for the given podcast.
  Future<List<Episode>> fetchEpisodes(Podcast currentPodcast,
      {bool forceRefresh = false}) async {
    String url = '$ApiRepository.scheduleUrl/${currentPodcast.podcastId}.json';

    return await apiRepository.fetchAndCacheJson(url, (jsonData) {
      selectedPodcastEpisodes = (json.decode(jsonData) as List)
          .map((i) => Episode.fromJson(i))
          .where((episode) => episode.hasPodcast)
          .toList();

      return selectedPodcastEpisodes;
    }, forceRefresh: forceRefresh);
  }
}

@riverpod
EpisodeRepository episodeRepository(EpisodeRepositoryRef ref) {
  return EpisodeRepository(
    apiRepository: ref.watch(apiRepositoryProvider),
  );
}

@riverpod
Future<List<Episode>> fetchEpisodes(
    FetchEpisodesRef ref, Podcast currentPodcast) {
  return ref.watch(episodeRepositoryProvider).fetchEpisodes(currentPodcast);
}
