import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/objectbox_repository.dart';
import 'package:rockserwis_podcaster/models/db/episode_db.dart';
import 'package:rockserwis_podcaster/objectbox.g.dart';

part 'episode_db_repository.g.dart';

@riverpod
class EpisodeList extends _$EpisodeList {
  @override
  Future<List<EpisodeDB>> build(int podcastId) async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    return objectBox.episodeBox
        .query(EpisodeDB_.podcastId.equals(podcastId))
        .build()
        .findAsync();
  }
}

/// Fetches all favorited episodes from the database.
@riverpod
class FavoritedEpisodes extends _$FavoritedEpisodes {
  @override
  Future<List<EpisodeDB>> build() async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    return objectBox.episodeBox
        .query(EpisodeDB_.isFavorited.equals(true))
        .build()
        .findAsync();
  }

  /// Toggles the favorite status of an episode.
  ///
  /// @param episode The episode to toggle the favorite status of.
  Future<void> toggleFavoriteEpisode(EpisodeDB episode) async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    bool isFavorited = true;

    if (episode.isFavorited != null) {
      isFavorited = !episode.isFavorited!;
    }

    final updatedEpisode = episode.copyWith(isFavorited: isFavorited);
    await objectBox.episodeBox.putAsync(updatedEpisode);

    ref.invalidateSelf();
    await future;
  }
}
