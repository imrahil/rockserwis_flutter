import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/objectbox_repository.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/objectbox.g.dart';

part 'episode_db_repository.g.dart';

@riverpod
class EpisodeList extends _$EpisodeList {
  @override
  Future<List<Episode>> build(int podcastId) async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    return objectBox.episodeBox
        .query(Episode_.podcastId.equals(podcastId))
        .build()
        .findAsync();
  }
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
