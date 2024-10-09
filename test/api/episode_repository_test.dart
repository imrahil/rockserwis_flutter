import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rockserwis_podcaster/api/const.dart';
import 'package:rockserwis_podcaster/api/episode_repository.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_test.data.dart';
import 'episode_repository_test.mocks.dart';

// Generate a mock client
@GenerateMocks([http.Client])
void main() {
  group('EpisodeRepository', () {
    late EpisodeRepository episodeRepository;
    late MockClient mockClient;

    setUp(() async {
      mockClient = MockClient();
      SharedPreferences.setMockInitialValues({});

      final sharedPreferences = await SharedPreferences.getInstance();

      episodeRepository = EpisodeRepository(
          client: mockClient, sharedPreferences: sharedPreferences);
    });

    group('fetchEpisodes', () {
      test('returns a list of episodes when successful', () async {
        when(mockClient.get(Uri.parse(
                '${Const.scheduleUrl}/${parsedMockPodcasts[0].podcastId}.json')))
            .thenAnswer((_) async => http.Response(
                json.encode(mockEpisodes), 200,
                headers: {'content-type': 'application/json; charset=utf-8'}));

        final episodes = await episodeRepository
            .fetchEpisodes(parsedMockPodcasts[0].podcastId);

        expect(episodes, isA<List<Episode>>());
        expect(episodes.length, parsedMockEpisodes.length);
        expect(episodes[0].episodeId, parsedMockEpisodes[0].episodeId);
        expect(episodes[1].name, parsedMockEpisodes[1].name);
      });

      test('throws an exception when unsuccessful', () async {
        when(mockClient.get(Uri.parse(
                '${Const.scheduleUrl}/${parsedMockPodcasts[0].podcastId}.json')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(
            () => episodeRepository
                .fetchEpisodes(parsedMockPodcasts[0].podcastId),
            throwsException);
      });
    });

    group('get Next/Previous Episode', () {
      setUp(() async {
        when(mockClient.get(Uri.parse(
                '${Const.scheduleUrl}/${parsedMockPodcasts[0].podcastId}.json')))
            .thenAnswer((_) async => http.Response(
                json.encode(mockEpisodes), 200,
                headers: {'content-type': 'application/json; charset=utf-8'}));
      });

      test('returns the previous episode in the list', () async {
        await episodeRepository.fetchEpisodes(parsedMockPodcasts[0].podcastId);

        final previousEpisode = episodeRepository.getPreviousEpisode(21284);
        expect(previousEpisode?.episodeId, 21359);

        final previousEpisode2 = episodeRepository.getPreviousEpisode(21359);
        expect(previousEpisode2, null);
      });

      test('returns the next episode in the list', () async {
        await episodeRepository.fetchEpisodes(parsedMockPodcasts[0].podcastId);
        final nextEpisode = episodeRepository.getNextEpisode(21359);
        expect(nextEpisode?.episodeId, 21284);

        final nextEpisode2 = episodeRepository.getNextEpisode(21284);
        expect(nextEpisode2, null);
      });
    });

    group('favorite episodes', () {
      // test('getFavoriteEpisodes returns empty list if no favorites', () async {
      //   final favorites = await episodeRepository.fetchFavoritedEpisodes();
      //   expect(favorites, isEmpty);
      // });

      // test('toggleFavoriteEpisode adds and removes episode from favorites',
      //     () async {
      //   final episode = parsedMockEpisodes[0];

      //   // Add to favorites
      //   await episodeRepository.toggleFavoriteEpisode(episode);
      //   var favorites = await episodeRepository.fetchFavoritedEpisodes();
      //   expect(favorites[0].episodeId, episode.episodeId);

      //   // Remove from favorites
      //   await episodeRepository.toggleFavoriteEpisode(episode);
      //   favorites = await episodeRepository.fetchFavoritedEpisodes();
      //   expect(favorites, isEmpty);
      // });

      // test('isFavoriteEpisode returns correct status', () async {
      //   final episode = parsedMockEpisodes[0];

      //   expect(episodeRepository.isFavoriteEpisode(episode), false);

      //   await episodeRepository.toggleFavoriteEpisode(episode);

      //   expect(episodeRepository.isFavoriteEpisode(episode), true);
      // });
    }, skip: true);
  });
}
