import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rockserwis_podcaster/components/episodes_list.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_test.data.dart';

void main() {
  group('EpisodesList', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('displays episodes correctly', (WidgetTester tester) async {
      final sharedPreferences = await SharedPreferences.getInstance();

      final myApp = ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: EpisodesList(
              episodes: parsedMockEpisodes,
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
        expect(find.text(episode.getEpisodeTitle()), findsOneWidget);
      }
    });
  });
}
