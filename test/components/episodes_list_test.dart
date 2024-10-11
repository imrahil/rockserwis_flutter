import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/components/episodes_list.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_test.data.dart';
import 'episodes_list_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('EpisodesList', () {
    late ApiRepository api;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('displays episodes correctly', (WidgetTester tester) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      api = ApiRepository(
        client: mockClient,
        sharedPreferences: sharedPreferences,
      );

      final myApp = ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
          apiRepositoryProvider.overrideWith((ref) => api),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: EpisodesList(
              episodes: parsedMockEpisodes,
              currentPodcast: parsedMockPodcasts[0],
            ),
          ),
        ),
      );

      await tester.pumpWidget(myApp);

      expect(find.byType(ListTile), findsNWidgets(parsedMockEpisodes.length));
      expect(find.byType(CachedNetworkImage),
          findsNWidgets(parsedMockEpisodes.length));

      for (var i = 0; i < parsedMockEpisodes.length; i++) {
        final episode = parsedMockEpisodes[i];
        expect(find.text(episode.getEpisodeTitle), findsOneWidget);
      }
    });
  });
}
