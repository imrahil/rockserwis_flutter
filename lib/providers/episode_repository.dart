import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/objectbox.g.dart';
import 'package:rockserwis_podcaster/providers/objectbox_repository.dart';
import 'package:rockserwis_podcaster/providers/sort_order.dart';
import 'package:rockserwis_podcaster/utils/const.dart';

part 'episode_repository.g.dart';

class EpisodeRepository {
  EpisodeRepository({required this.client});

  final http.Client client;

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
EpisodeRepository episodeRepository(Ref ref) {
  return EpisodeRepository(
    client: http.Client(),
  );
}

@riverpod
Future<List<Episode>> fetchEpisodes(Ref ref, int podcastId) {
  return ref.watch(episodeRepositoryProvider).fetchEpisodes(podcastId);
}

@Riverpod(keepAlive: true)
class AllEpisodes extends _$AllEpisodes {
  @override
  Future<List<Episode>> build() => getAll();

  Future<List<Episode>> getAll() async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    return objectBox.episodeBox.getAllAsync();
  }

  /// Toggles the favorite status of an episode.
  ///
  /// @param episode The episode to toggle the favorite status of.
  Future<void> toggleFavoriteEpisode(int episodeId) async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    final episode = await getSingleEpisode(objectBox, episodeId);

    if (episode != null) {
      final updatedEpisode =
          episode.copyWith(isFavorited: !episode.isFavorited);
      await objectBox.episodeBox.putAsync(updatedEpisode);
      await updateList(updatedEpisode);
    }
  }

  Future<void> updateTimestamp(int episodeId) async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    final episode = await getSingleEpisode(objectBox, episodeId);

    if (episode != null) {
      final updatedEpisode = episode.copyWith(updatedAt: DateTime.now());

      await objectBox.episodeBox.putAsync(updatedEpisode);
      await updateList(updatedEpisode);
    }
  }

  Future<void> resetTimestamp() async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    var resetDate = DateTime.utc(2000, 1, 1);

    final historyItems = state.requireValue
        .where((episode) => episode.updatedAt!.isAfter(resetDate))
        .toList();

    if (historyItems.isNotEmpty) {
      final updatedEpisodes = historyItems.map((episode) {
        return episode.copyWith(updatedAt: resetDate);
      }).toList();

      await objectBox.episodeBox.putManyAsync(updatedEpisodes);
      state = await AsyncValue.guard(getAll);
    }
  }

  Future<void> updateProgress(int episodeId, int progress, int total) async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    final episode = await getSingleEpisode(objectBox, episodeId);

    if (episode != null) {
      final updatedEpisode = episode.copyWith(
        progress: progress,
        total: total,
      );

      await objectBox.episodeBox.putAsync(updatedEpisode);
      await updateList(updatedEpisode);
    }
  }

  Future<void> updateList(Episode updatedEpisode) async {
    await update((previousState) => [
          ...previousState.map(
            (episode) => episode.episodeId == updatedEpisode.episodeId
                ? updatedEpisode
                : episode,
          ),
        ]);
  }

  Future<Episode?> getSingleEpisode(objectBox, int episodeId) async {
    return objectBox.episodeBox
        .query(Episode_.episodeId.equals(episodeId))
        .build()
        .findFirstAsync();
  }
}

@riverpod
Future<List<Episode>> episodeList(Ref ref, int podcastId) async {
  final allEpisodesList = await ref.watch(allEpisodesProvider.future);

  final episodes = allEpisodesList
      .where((episode) => episode.podcastId == podcastId)
      .toList();

  final sorted = switch (ref.watch(sortOrderProvider)) {
    SortOrderType.ascending => episodes
      ..sort((a, b) => a.date.compareTo(b.date)),
    SortOrderType.descending => episodes
      ..sort((a, b) => b.date.compareTo(a.date)),
  };

  return sorted;
}

/// Fetches all episodes from the history.
@riverpod
Future<List<Episode>> historyEpisodes(Ref ref) async {
  final allEpisodesList = await ref.watch(allEpisodesProvider.future);

  final recentItems = allEpisodesList
      .where((episode) =>
          DateTime.now().difference(episode.updatedAt!).inDays <= 10)
      .toList();

  recentItems.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));

  return recentItems.take(10).toList();
}

/// Fetches all favorited episodes from the database.
@riverpod
Future<List<Episode>> favoritedEpisodes(Ref ref) async {
  final allEpisodesList = await ref.watch(allEpisodesProvider.future);

  final favorites =
      allEpisodesList.where((episode) => episode.isFavorited).toList();

  favorites.sort((a, b) => a.name.compareTo(b.name));

  return favorites;
}

@riverpod
Future<bool> watchFavoritedEpisode(Ref ref, int episodeId) async {
  final allEpisodesList = await ref.watch(allEpisodesProvider.future);

  return allEpisodesList
      .firstWhere((episode) => episode.episodeId == episodeId)
      .isFavorited;
}
