import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rockserwis_podcaster/components/podcasts_list.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_test.data.dart';

void main() {
  group('PodcastsList', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('displays podcasts correctly', (WidgetTester tester) async {
      final sharedPreferences = await SharedPreferences.getInstance();

      final myApp = ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: PodcastsList(
              podcasts: parsedMockPodcasts,
            ),
          ),
        ),
      );

      await tester.pumpWidget(myApp);

      expect(find.byType(ListTile), findsNWidgets(parsedMockPodcasts.length));
      expect(find.byType(CachedNetworkImage),
          findsNWidgets(parsedMockPodcasts.length));

      for (var i = 0; i < parsedMockPodcasts.length; i++) {
        final podcast = parsedMockPodcasts[i];
        expect(find.text(podcast.podcastName), findsOneWidget);
        expect(find.text('Podcast ID: ${podcast.podcastId}'), findsOneWidget);
      }
    });
  });
}
