import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:objectbox/objectbox.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/objectbox.g.dart';
import 'package:rockserwis_podcaster/providers/episode_repository.dart';
import 'package:rockserwis_podcaster/providers/objectbox_repository.dart';
import 'package:rockserwis_podcaster/providers/podcast_repository.dart';
import 'package:rockserwis_podcaster/providers/podcast_sync_helper.dart';

import 'podcast_sync_helper_test.mocks.dart';

@GenerateMocks(
  [PodcastJsonRepository, EpisodeRepository, ObjectBox, Box, Query],
  customMocks: [
    MockSpec<QueryBuilder>(unsupportedMembers: {
      #link,
      #backlink,
      #linkMany,
      #backlinkMany,
    }),
  ],
)
void main() {
  late MockPodcastJsonRepository mockPodcastRepository;
  late MockEpisodeRepository mockEpisodeRepository;
  late MockObjectBox mockObjectBox;
  late MockBox<Podcast> mockPodcastBox;
  late MockBox<Episode> mockEpisodeBox;
  late PodcastSyncHelper syncHelper;

  Podcast buildPodcast({required int podcastId, bool isFavorited = false}) {
    return Podcast(
      podcastId: podcastId,
      podcastName: 'Podcast $podcastId',
      authors: ToMany(),
      schedules: ToMany(),
      onlyMusic: false,
      isActive: true,
      hasEpisodes: true,
      isFavorited: isFavorited,
    );
  }

  Episode buildEpisode({required int episodeId, int? podcastId}) {
    return Episode(
      episodeId: episodeId,
      podcastId: podcastId,
      date: DateTime.utc(2026, 1, 1),
      name: 'Episode $episodeId',
      hasPodcast: true,
    );
  }

  // Stubs the query().build().findAsync() chain used by
  // PodcastSyncHelper.fetchEpisodesFromDB for every podcast.
  void stubLocalEpisodes(List<Episode> localEpisodes) {
    final queryBuilder = MockQueryBuilder<Episode>();
    final query = MockQuery<Episode>();
    when(mockEpisodeBox.query(any)).thenReturn(queryBuilder);
    when(queryBuilder.build()).thenReturn(query);
    when(query.findAsync()).thenAnswer((_) async => localEpisodes);
  }

  setUp(() {
    mockPodcastRepository = MockPodcastJsonRepository();
    mockEpisodeRepository = MockEpisodeRepository();
    mockObjectBox = MockObjectBox();
    mockPodcastBox = MockBox<Podcast>();
    mockEpisodeBox = MockBox<Episode>();

    when(mockObjectBox.podcastBox).thenReturn(mockPodcastBox);
    when(mockObjectBox.episodeBox).thenReturn(mockEpisodeBox);
    when(mockPodcastBox.putManyAsync(any))
        .thenAnswer((_) async => <int>[]);
    when(mockEpisodeBox.putManyAsync(any))
        .thenAnswer((_) async => <int>[]);

    syncHelper = PodcastSyncHelper(
      podcastRepository: mockPodcastRepository,
      episodeRepository: mockEpisodeRepository,
      dbProvider: mockObjectBox,
    );
  });

  group('syncPodcasts', () {
    test('only writes podcasts that are not already stored locally',
        () async {
      final existing = buildPodcast(podcastId: 1);
      final newRemote = buildPodcast(podcastId: 2);

      when(mockPodcastRepository.fetchPodcasts())
          .thenAnswer((_) async => [existing, newRemote]);
      when(mockPodcastBox.getAllAsync()).thenAnswer((_) async => [existing]);

      await syncHelper.syncPodcasts();

      final captured = verify(mockPodcastBox.putManyAsync(captureAny))
          .captured
          .single as List<Podcast>;
      expect(captured.length, 1);
      expect(captured.single.podcastId, 2);
    });

    test('does not touch the database when there are no new podcasts',
        () async {
      final existing = buildPodcast(podcastId: 1);

      when(mockPodcastRepository.fetchPodcasts())
          .thenAnswer((_) async => [existing]);
      when(mockPodcastBox.getAllAsync()).thenAnswer((_) async => [existing]);

      await syncHelper.syncPodcasts();

      verifyNever(mockPodcastBox.putManyAsync(any));
    });
  });

  group('syncEpisodes', () {
    test('only returns new episodes belonging to favorited podcasts',
        () async {
      final favoritedPodcast = buildPodcast(podcastId: 1, isFavorited: true);
      final unfavoritedPodcast = buildPodcast(podcastId: 2);

      when(mockPodcastBox.getAllAsync())
          .thenAnswer((_) async => [favoritedPodcast, unfavoritedPodcast]);
      stubLocalEpisodes([]);

      when(mockEpisodeRepository.fetchEpisodes(1))
          .thenAnswer((_) async => [buildEpisode(episodeId: 100)]);
      when(mockEpisodeRepository.fetchEpisodes(2))
          .thenAnswer((_) async => [buildEpisode(episodeId: 200)]);

      final newFavorited = await syncHelper.syncEpisodes();

      expect(newFavorited.length, 1);
      expect(newFavorited.single.episodeId, 100);
    });

    test('does not re-add episodes that already exist locally', () async {
      final favoritedPodcast = buildPodcast(podcastId: 1, isFavorited: true);
      final existingEpisode = buildEpisode(episodeId: 100, podcastId: 1);

      when(mockPodcastBox.getAllAsync())
          .thenAnswer((_) async => [favoritedPodcast]);
      stubLocalEpisodes([existingEpisode]);

      when(mockEpisodeRepository.fetchEpisodes(1)).thenAnswer((_) async => [
            existingEpisode,
            buildEpisode(episodeId: 101, podcastId: 1),
          ]);

      final newFavorited = await syncHelper.syncEpisodes();

      expect(newFavorited.length, 1);
      expect(newFavorited.single.episodeId, 101);

      final captured = verify(mockEpisodeBox.putManyAsync(captureAny))
          .captured
          .single as List<Episode>;
      expect(captured.length, 1);
      expect(captured.single.episodeId, 101);
    });

    test('initializes new episodes with the podcastId and history sentinel',
        () async {
      final favoritedPodcast = buildPodcast(podcastId: 1, isFavorited: true);

      when(mockPodcastBox.getAllAsync())
          .thenAnswer((_) async => [favoritedPodcast]);
      stubLocalEpisodes([]);
      when(mockEpisodeRepository.fetchEpisodes(1))
          .thenAnswer((_) async => [buildEpisode(episodeId: 100)]);

      final newFavorited = await syncHelper.syncEpisodes();

      expect(newFavorited.single.podcastId, 1);
      expect(newFavorited.single.updatedAt, DateTime.utc(2000, 1, 1));
    });

    test('does not write to the database when there are no new episodes',
        () async {
      final favoritedPodcast = buildPodcast(podcastId: 1, isFavorited: true);
      final existingEpisode = buildEpisode(episodeId: 100, podcastId: 1);

      when(mockPodcastBox.getAllAsync())
          .thenAnswer((_) async => [favoritedPodcast]);
      stubLocalEpisodes([existingEpisode]);
      when(mockEpisodeRepository.fetchEpisodes(1))
          .thenAnswer((_) async => [existingEpisode]);

      final newFavorited = await syncHelper.syncEpisodes();

      expect(newFavorited, isEmpty);
      verifyNever(mockEpisodeBox.putManyAsync(any));
    });
  });
}
