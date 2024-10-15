import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/const.dart';
import 'package:rockserwis_podcaster/providers/objectbox_repository.dart';
import 'package:rockserwis_podcaster/providers/sort_order.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/objectbox.g.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'episode_repository.g.dart';

class EpisodeRepository {
  EpisodeRepository({required this.client, required this.sharedPreferences});

  final http.Client client;
  final SharedPreferences sharedPreferences;

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
Future<List<Episode>> episodeList(EpisodeListRef ref, int podcastId) async {
  final objectBox = await ref.watch(objectBoxProvider.future);

  final episodes = await objectBox.episodeBox
      .query(Episode_.podcastId.equals(podcastId))
      .build()
      .findAsync();

  final sorted = switch (ref.watch(sortOrderProvider)) {
    SortOrderType.ascending => episodes
      ..sort((a, b) => a.date.compareTo(b.date)),
    SortOrderType.descending => episodes
      ..sort((a, b) => b.date.compareTo(a.date)),
  };

  return sorted;
}

/// Fetches all favorited episodes from the database.
@riverpod
class FavoritedEpisodes extends _$FavoritedEpisodes {
  @override
  Future<List<Episode>> build() async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    return objectBox.episodeBox
        .query(Episode_.isFavorited.equals(true))
        .build()
        .findAsync();
  }

  /// Toggles the favorite status of an episode.
  ///
  /// @param episode The episode to toggle the favorite status of.
  Future<void> toggleFavoriteEpisode(Episode episode) async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    final updatedEpisode = episode.copyWith(isFavorited: !episode.isFavorited);
    await objectBox.episodeBox.putAsync(updatedEpisode);

    ref.invalidateSelf();
    await future;
  }
}
