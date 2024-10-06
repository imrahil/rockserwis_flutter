import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/episode_repository.dart';
import 'package:rockserwis_podcaster/api/objectbox_repository.dart';
import 'package:rockserwis_podcaster/api/podcast_repository.dart';
import 'package:rockserwis_podcaster/models/db/episode_db.dart';
import 'package:rockserwis_podcaster/models/db/podcast_db.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/objectbox.g.dart';

part 'podcast_sync_helper.g.dart';

class PodcastSyncHelper {
  final PodcastRepository podcastRepository;
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
    List<PodcastDB> localPodcasts = await fetchAllPodcastsFromDB();

    /// Get the set of podcastIds from the local database
    Set<int?> localPodcastIds = localPodcasts.map((p) => p.podcastId).toSet();
    List<PodcastDB> newPodcasts = [];

    /// Add new podcasts to the local database
    for (Podcast remotePodcast in remotePodcasts) {
      if (!localPodcastIds.contains(remotePodcast.podcastId)) {
        PodcastDB newPodcastDB = PodcastDB.fromPodcast(remotePodcast);
        newPodcasts.add(newPodcastDB);
      }
    }

    if (newPodcasts.isNotEmpty) {
      await dbProvider.podcastBox.putManyAsync(newPodcasts);
    }
  }

  // Method to compare and add new episodes to the local database
  Future<void> syncEpisodes() async {
    List<PodcastDB> localPodcasts = await fetchAllPodcastsFromDB();

    for (PodcastDB podcast in localPodcasts) {
      if (podcast.podcastId != null) {
        List<Episode> remoteEpisodes =
            await episodeRepository.fetchEpisodes(podcast.podcastId!);
        List<EpisodeDB> localEpisodes =
            await fetchEpisodesFromDB(podcast.podcastId!);

        Set<int?> localEpisodeIds =
            localEpisodes.map((e) => e.episodeId).toSet();
        List<EpisodeDB> newEpisodes = [];

        for (Episode remoteEpisode in remoteEpisodes) {
          if (!localEpisodeIds.contains(remoteEpisode.episodeId)) {
            EpisodeDB newEpisodeDB =
                EpisodeDB.fromEpisode(remoteEpisode, podcast.podcastId!);
            newEpisodes.add(newEpisodeDB);
          }
        }
        if (newEpisodes.isNotEmpty) {
          await dbProvider.episodeBox.putManyAsync(newEpisodes);
        }
      }
    }
  }

  // Method to fetch all podcasts from the local database
  Future<List<PodcastDB>> fetchAllPodcastsFromDB() {
    return dbProvider.podcastBox.getAllAsync();
  }

  // Method to fetch episodes from the local database for a podcast
  Future<List<EpisodeDB>> fetchEpisodesFromDB(int podcastId) {
    return dbProvider.episodeBox
        .query(EpisodeDB_.podcastId.equals(podcastId))
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
