import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/objectbox_repository.dart';
import 'package:rockserwis_podcaster/models/db/podcast_db.dart';
import 'package:rockserwis_podcaster/objectbox.g.dart';

part 'podcast_db_repository.g.dart';

@riverpod
Future<List<PodcastDB>> podcastList(PodcastListRef ref) async {
  final objectBox = await ref.watch(objectBoxProvider.future);

  return objectBox.podcastBox.getAllAsync();
}

/// Fetches all favorited podcasts from the database.
@riverpod
class FavoritedPodcasts extends _$FavoritedPodcasts {
  @override
  Future<List<PodcastDB>> build() async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    return objectBox.podcastBox
        .query(PodcastDB_.isFavorited.equals(true))
        .build()
        .findAsync();
  }

  /// Toggles the favorite status of an podcast.
  ///
  /// @param podcast The episode to toggle the favorite status of.
  Future<void> toggleFavoritePodcast(PodcastDB podcast) async {
    final objectBox = await ref.watch(objectBoxProvider.future);

    bool isFavorited = true;

    if (podcast.isFavorited != null) {
      isFavorited = !podcast.isFavorited!;
    }

    final updatedPodcast = podcast.copyWith(isFavorited: isFavorited);
    await objectBox.podcastBox.putAsync(updatedPodcast);

    ref.invalidateSelf();
    await future;
  }
}
