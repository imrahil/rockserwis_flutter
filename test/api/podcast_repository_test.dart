import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/api/data/missing_podcasts.dart';
import 'package:rockserwis_podcaster/api/podcast_repository.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_test.data.dart';
import 'podcast_repository_test.mocks.dart';

// Generate a mock client
@GenerateMocks([http.Client])
void main() {
  group('PodcastRepository', () {
    late PodcastRepository podcastRepository;
    late MockClient mockClient;
    late ApiRepository apiRepository;

    setUp(() async {
      mockClient = MockClient();
      SharedPreferences.setMockInitialValues({});

      final sharedPreferences = await SharedPreferences.getInstance();
      apiRepository = ApiRepository(
          client: mockClient, sharedPreferences: sharedPreferences);

      podcastRepository = PodcastRepository(
          apiRepository: apiRepository, sharedPreferences: sharedPreferences);
    });

    group('fetchPodcasts', () {
      test('returns a list of podcasts when successful', () async {
        when(mockClient.get(Uri.parse(ApiRepository.broadCastUrl))).thenAnswer(
            (_) async => http.Response(json.encode(mockPodcasts), 200,
                headers: {'content-type': 'application/json; charset=utf-8'}));

        final podcasts =
            await podcastRepository.fetchPodcasts(forceRefresh: true);

        expect(podcasts, isA<List<Podcast>>());
        expect(podcasts.length, mockPodcasts.length + missingPodcasts.length);
        expect(podcasts[0].podcastId, 7);
        expect(podcasts[1].podcastName, "Będzie głłośno");

        expect(podcasts[3].authors.length, 1);
        expect(podcasts[3].authors[0].name, "Baśnia");

        expect(podcasts[3].schedules.length, 1);
        expect(podcasts[3].schedules[0].weekday, 5);
        expect(podcasts[3].schedules[0].start, "21:00:00");
        expect(podcasts[3].schedules[0].end, "23:00:00");

        expect(podcasts[4].onlyMusic, false);
        expect(podcasts[4].isActive, true);
        expect(podcasts[4].hasEpisodes, true);
        expect(podcasts[4].image,
            "/static/media/broadcasts/doctor-doctor_1000x1000.jpg");
      });

      test('throws an exception when unsuccessful', () async {
        when(mockClient.get(Uri.parse(ApiRepository.broadCastUrl)))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(() => podcastRepository.fetchPodcasts(forceRefresh: true),
            throwsException);
      });

      test('uses cached data when forceRefresh is false', () async {
        // Fetch once to cache the data
        when(mockClient.get(Uri.parse(ApiRepository.broadCastUrl))).thenAnswer(
            (_) async => http.Response(json.encode(mockPodcasts), 200,
                headers: {'content-type': 'application/json; charset=utf-8'}));
        await podcastRepository.fetchPodcasts();

        // Mock a different response for the next call
        when(mockClient.get(Uri.parse(ApiRepository.broadCastUrl)))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // Should still return the cached data
        final podcasts = await podcastRepository.fetchPodcasts();
        expect(podcasts, isA<List<Podcast>>());
        expect(podcasts.length, mockPodcasts.length + missingPodcasts.length);
      });
    });

    group('favorite podcasts', () {
      test('getFavoritePodcasts returns empty list if no favorites', () async {
        final favorites = await podcastRepository.fetchFavoritedPodcasts();
        expect(favorites, isEmpty);
      });

      test('toggleFavoritePodcast adds and removes podcast from favorites',
          () async {
        final podcast = parsedMockPodcasts[0];

        // Add to favorites
        await podcastRepository.toggleFavoritePodcast(podcast);
        var favorites = await podcastRepository.fetchFavoritedPodcasts();
        expect(favorites[0].podcastId, podcast.podcastId);

        // Remove from favorites
        await podcastRepository.toggleFavoritePodcast(podcast);
        favorites = await podcastRepository.fetchFavoritedPodcasts();
        expect(favorites, isEmpty);
      });

      test('isFavoritePodcast returns correct status', () async {
        final podcast = parsedMockPodcasts[0];

        expect(podcastRepository.isFavoritePodcast(podcast), false);

        await podcastRepository.toggleFavoritePodcast(podcast);

        expect(podcastRepository.isFavoritePodcast(podcast), true);
      });
    });
  });
}
