import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/episode_repository.dart';
import 'package:rockserwis_podcaster/api/objectbox_repository.dart';
import 'package:rockserwis_podcaster/api/podcast_json_repository.dart';
import 'package:rockserwis_podcaster/app_startup.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/objectbox.g.dart';

part 'podcast_sync_helper.g.dart';

class PodcastSyncHelper {
  final PodcastJsonRepository podcastRepository;
  final EpisodeRepository episodeRepository;
  final ObjectBox dbProvider;

  PodcastSyncHelper({
    required this.podcastRepository,
    required this.episodeRepository,
    required this.dbProvider,
  });

  // Method to sync both podcasts and episodes
  Future<void> syncAll() async {
    await syncPodcasts();
    await syncEpisodes();
  }

  // Method to compare and add new podcasts to the local database
  Future<void> syncPodcasts() async {
    List<Podcast> remotePodcasts = await podcastRepository.fetchPodcasts();
    List<Podcast> localPodcasts = await fetchAllPodcastsFromDB();

    /// Get the set of podcastIds from the local database
    Set<int?> localPodcastIds = localPodcasts.map((p) => p.podcastId).toSet();
    List<Podcast> newPodcasts = [];

    /// Add new podcasts to the local database
    for (Podcast remotePodcast in remotePodcasts) {
      if (!localPodcastIds.contains(remotePodcast.podcastId)) {
        newPodcasts.add(remotePodcast);
      }
    }

    if (newPodcasts.isNotEmpty) {
      logger.d('Adding ${newPodcasts.length} new podcasts');

      await dbProvider.podcastBox.putManyAsync(newPodcasts);
    }
  }

  // Method to compare and add new episodes to the local database
  Future<void> syncEpisodes() async {
    List<Podcast> localPodcasts = await fetchAllPodcastsFromDB();

    for (Podcast podcast in localPodcasts) {
      List<Episode> remoteEpisodes =
          await episodeRepository.fetchEpisodes(podcast.podcastId);
      List<Episode> localEpisodes =
          await fetchEpisodesFromDB(podcast.podcastId);

      Set<int?> localEpisodeIds = localEpisodes.map((e) => e.episodeId).toSet();
      List<Episode> newEpisodes = [];

      for (Episode remoteEpisode in remoteEpisodes) {
        if (!localEpisodeIds.contains(remoteEpisode.episodeId)) {
          Episode newEpisode =
              remoteEpisode.copyWith(podcastId: podcast.podcastId);
          newEpisodes.add(newEpisode);
        }
      }
      if (newEpisodes.isNotEmpty) {
        logger.d(
            'Adding ${newEpisodes.length} new episodes to podcast: ${podcast.podcastName}');

        await dbProvider.episodeBox.putManyAsync(newEpisodes);
      }
    }
  }

  // Method to fetch all podcasts from the local database
  Future<List<Podcast>> fetchAllPodcastsFromDB() {
    return dbProvider.podcastBox.getAllAsync();
  }

  // Method to fetch episodes from the local database for a podcast
  Future<List<Episode>> fetchEpisodesFromDB(int podcastId) {
    return dbProvider.episodeBox
        .query(Episode_.podcastId.equals(podcastId))
        .build()
        .findAsync();
  }
}

@riverpod
PodcastSyncHelper podcastSyncHelper(PodcastSyncHelperRef ref) {
  return PodcastSyncHelper(
    podcastRepository: ref.watch(podcastRepositoryProvider),
    episodeRepository: ref.watch(episodeRepositoryProvider),
    dbProvider: ref.watch(objectBoxProvider).requireValue,
  );
}
