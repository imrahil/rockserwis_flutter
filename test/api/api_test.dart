import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

// Generate a mock client
@GenerateMocks([http.Client])
void main() {
  // group('API', () {
  //   late API api;
  //   late MockClient mockClient;

  //   setUp(() {
  //     mockClient = MockClient();
  //     api = API(client: mockClient);
  //     SharedPreferences.setMockInitialValues({});
  //   });

  //   group('getPodcasts', () {
  //     test('returns a list of podcasts when successful', () async {
  //       when(mockClient.get(Uri.parse(API.broadCastUrl))).thenAnswer(
  //           (_) async => http.Response(json.encode(mockPodcasts), 200,
  //               headers: {'content-type': 'application/json; charset=utf-8'}));

  //       final podcasts = await api.getPodcasts(forceRefresh: true);

  //       expect(podcasts, isA<List<Podcast>>());
  //       expect(podcasts.length, mockPodcasts.length + missingPodcasts.length);
  //       expect(podcasts[0].podcastId, 7);
  //       expect(podcasts[1].podcastName, "Będzie głłośno");

  //       expect(podcasts[3].authors.length, 1);
  //       expect(podcasts[3].authors[0].name, "Baśnia");

  //       expect(podcasts[3].schedules.length, 1);
  //       expect(podcasts[3].schedules[0].weekday, 5);
  //       expect(podcasts[3].schedules[0].start, "21:00:00");
  //       expect(podcasts[3].schedules[0].end, "23:00:00");

  //       expect(podcasts[4].onlyMusic, false);
  //       expect(podcasts[4].isActive, true);
  //       expect(podcasts[4].hasEpisodes, true);
  //       expect(podcasts[4].image,
  //           "/static/media/broadcasts/doctor-doctor_1000x1000.jpg");
  //     });

  //     test('throws an exception when unsuccessful', () async {
  //       when(mockClient.get(Uri.parse(API.broadCastUrl)))
  //           .thenAnswer((_) async => http.Response('Not Found', 404));

  //       expect(() => api.getPodcasts(forceRefresh: true), throwsException);
  //     });

  //     test('uses cached data when forceRefresh is false', () async {
  //       // Fetch once to cache the data
  //       when(mockClient.get(Uri.parse(API.broadCastUrl))).thenAnswer(
  //           (_) async => http.Response(json.encode(mockPodcasts), 200,
  //               headers: {'content-type': 'application/json; charset=utf-8'}));
  //       await api.getPodcasts();

  //       // Mock a different response for the next call
  //       when(mockClient.get(Uri.parse(API.broadCastUrl)))
  //           .thenAnswer((_) async => http.Response('Not Found', 404));

  //       // Should still return the cached data
  //       final podcasts = await api.getPodcasts();
  //       expect(podcasts, isA<List<Podcast>>());
  //       expect(podcasts.length, mockPodcasts.length + missingPodcasts.length);
  //     });
  //   });

  //   group('getEpisodes', () {
  //     test('returns a list of episodes when successful', () async {
  //       when(mockClient.get(Uri.parse(
  //               '${API.scheduleUrl}/${parsedMockPodcasts[0].podcastId}.json')))
  //           .thenAnswer((_) async => http.Response(
  //               json.encode(mockEpisodes), 200,
  //               headers: {'content-type': 'application/json; charset=utf-8'}));

  //       final episodes =
  //           await api.getEpisodes(parsedMockPodcasts[0], forceRefresh: true);

  //       expect(episodes, isA<List<Episode>>());
  //       expect(episodes.length, parsedMockEpisodes.length);
  //       expect(episodes[0].episodeId, parsedMockEpisodes[0].episodeId);
  //       expect(episodes[1].name, parsedMockEpisodes[1].name);
  //     });

  //     test('throws an exception when unsuccessful', () async {
  //       when(mockClient.get(Uri.parse(
  //               '${API.scheduleUrl}/${parsedMockPodcasts[0].podcastId}.json')))
  //           .thenAnswer((_) async => http.Response('Not Found', 404));

  //       expect(() => api.getEpisodes(parsedMockPodcasts[0], forceRefresh: true),
  //           throwsException);
  //     });
  //   });

  //   group('login', () {
  //     test('returns true when login is successful', () async {
  //       when(mockClient.get(Uri.parse(API.loginCsrfUrl))).thenAnswer(
  //           (_) async => http.Response('test_csrf_token', 200, headers: {
  //                 'content-type': 'application/json; charset=utf-8',
  //                 'set-cookie':
  //                     'csrftoken=test_csrf_cookie;session=test_session_cookie'
  //               }));

  //       when(mockClient.post(Uri.parse(API.loginPostUrl),
  //               body: anyNamed('body'), headers: anyNamed('headers')))
  //           .thenAnswer((_) async => http.Response('', 200, headers: {
  //                 'content-type': 'application/json; charset=utf-8',
  //                 'set-cookie':
  //                     'sessionid=test_session_cookie;session=test_session_cookie'
  //               }));

  //       final result = await api.login('test@email.com', 'password', false);

  //       expect(result, true);
  //       expect(api.masterCookie, 'csrftoken=test_csrf_cookie');
  //       expect(api.sessionCookie, 'sessionid=test_session_cookie');
  //     });

  //     test('returns false when login is unsuccessful', () async {
  //       when(mockClient.get(Uri.parse(API.loginCsrfUrl)))
  //           .thenAnswer((_) async => http.Response('Not Found', 404));

  //       final result = await api.login('test@email.com', 'password', false);

  //       expect(result, false);
  //     });

  //     test('returns true when login is with rememberMe', () async {
  //       when(mockClient.get(Uri.parse(API.loginCsrfUrl))).thenAnswer(
  //           (_) async => http.Response('test_csrf_token', 200, headers: {
  //                 'content-type': 'application/json; charset=utf-8',
  //                 'set-cookie':
  //                     'csrftoken=test_csrf_cookie;session=test_session_cookie'
  //               }));

  //       when(mockClient.post(Uri.parse(API.loginPostUrl),
  //               body: anyNamed('body'), headers: anyNamed('headers')))
  //           .thenAnswer((_) async => http.Response('', 200, headers: {
  //                 'content-type': 'application/json; charset=utf-8',
  //                 'set-cookie':
  //                     'sessionid=test_session_cookie;session=test_session_cookie'
  //               }));

  //       final result = await api.login('test@email.com', 'password', true);

  //       expect(result, true);

  //       final prefs = await SharedPreferences.getInstance();
  //       expect(prefs.getBool('rememberMe'), true);
  //       expect(prefs.getString('masterCookie'), 'csrftoken=test_csrf_cookie');
  //       expect(
  //           prefs.getString('sessionCookie'), 'sessionid=test_session_cookie');
  //     });
  //   });

  //   group('logout', () {
  //     test('clears cookies and SharedPreferences', () async {
  //       final prefs = await SharedPreferences.getInstance();
  //       await prefs.setBool('rememberMe', true);
  //       await prefs.setString('masterCookie', 'test_master_cookie');
  //       await prefs.setString('sessionCookie', 'test_session_cookie');

  //       await api.logout();

  //       expect(prefs.getBool('rememberMe'), false);
  //       expect(prefs.getString('masterCookie'), null);
  //       expect(prefs.getString('sessionCookie'), null);
  //     });
  //   });

  //   group('getEpisodeUrl', () {
  //     test('returns the correct episode URL', () {
  //       const episodeId = 123;
  //       const expectedUrl = '${API.mainUrl}/podcast/$episodeId';
  //       expect(api.getEpisodeUrl(episodeId), expectedUrl);
  //     });
  //   });

  //   group('getImagePath', () {
  //     test('returns the correct image path', () {
  //       const imageUrl = 'images/test.jpg';
  //       const expectedPath = '${API.mainUrl}/$imageUrl';
  //       expect(api.getImagePath(imageUrl), expectedPath);
  //     });
  //   });

  //   group('getHeaders', () {
  //     test('returns the correct headers with cookies', () {
  //       api.masterCookie = 'master=cookie1';
  //       api.sessionCookie = 'session=cookie2';
  //       final expectedHeaders = {
  //         'Cookie': 'master=cookie1;session=cookie2',
  //       };
  //       expect(api.getHeaders(), expectedHeaders);
  //     });
  //   });

  //   group('parseCookie', () {
  //     test('returns the parsed cookie from the response headers', () {
  //       final response = http.Response('', 200,
  //           headers: {'set-cookie': 'test_cookie=value; Path=/; HttpOnly'});
  //       final parsedCookie = api.parseCookie(response);
  //       expect(parsedCookie, 'test_cookie=value');
  //     });
  //   });

  //   group('getPreviousEpisode', () {
  //     test('returns the previous episode in the list', () {
  //       api.selectedPodcastEpisodes = parsedMockEpisodes;

  //       final previousEpisode = api.getPreviousEpisode(21284);
  //       expect(previousEpisode?.episodeId, 21359);

  //       final previousEpisode2 = api.getPreviousEpisode(21359);
  //       expect(previousEpisode2, null);
  //     });
  //   });

  //   group('getNextEpisode', () {
  //     test('returns the next episode in the list', () {
  //       api.selectedPodcastEpisodes = parsedMockEpisodes;

  //       final nextEpisode = api.getNextEpisode(21359);
  //       expect(nextEpisode?.episodeId, 21284);

  //       final nextEpisode2 = api.getNextEpisode(21284);
  //       expect(nextEpisode2, null);
  //     });
  //   });

  //   group('favorite podcasts', () {
  //     test('getFavoritePodcasts returns empty list if no favorites', () async {
  //       final favorites = await api.getFavoritePodcasts();
  //       expect(favorites, isEmpty);
  //     });

  //     test('toggleFavoritePodcast adds and removes podcast from favorites',
  //         () async {
  //       final podcast = parsedMockPodcasts[0];

  //       // Add to favorites
  //       await api.toggleFavoritePodcast(podcast);
  //       var favorites = await api.getFavoritePodcasts();
  //       expect(favorites[0].podcastId, podcast.podcastId);

  //       // Remove from favorites
  //       await api.toggleFavoritePodcast(podcast);
  //       favorites = await api.getFavoritePodcasts();
  //       expect(favorites, isEmpty);
  //     });

  //     test('isFavoritePodcast returns correct status', () async {
  //       final podcast = parsedMockPodcasts[0];

  //       expect(await api.isFavoritePodcast(podcast), false);

  //       await api.toggleFavoritePodcast(podcast);

  //       expect(await api.isFavoritePodcast(podcast), true);
  //     });
  //   });

  //   group('favorite episodes', () {
  //     test('getFavoriteEpisodes returns empty list if no favorites', () async {
  //       final favorites = await api.getFavoriteEpisodes();
  //       expect(favorites, isEmpty);
  //     });

  //     test('toggleFavoriteEpisode adds and removes episode from favorites',
  //         () async {
  //       final episode = parsedMockEpisodes[0];

  //       // Add to favorites
  //       await api.toggleFavoriteEpisode(episode);
  //       var favorites = await api.getFavoriteEpisodes();
  //       expect(favorites[0].episodeId, episode.episodeId);

  //       // Remove from favorites
  //       await api.toggleFavoriteEpisode(episode);
  //       favorites = await api.getFavoriteEpisodes();
  //       expect(favorites, isEmpty);
  //     });

  //     test('isFavoriteEpisode returns correct status', () async {
  //       final episode = parsedMockEpisodes[0];

  //       expect(await api.isFavoriteEpisode(episode), false);

  //       await api.toggleFavoriteEpisode(episode);

  //       expect(await api.isFavoriteEpisode(episode), true);
  //     });
  //   });
  // });
}
