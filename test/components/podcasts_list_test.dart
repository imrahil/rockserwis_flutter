// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:provider/provider.dart';
// import 'package:rockserwis_podcaster/api/api.dart';
// import 'package:rockserwis_podcaster/components/podcasts_list.dart';

// import '../api/api_test.data.dart';
// import '../api/api_test.mocks.dart';

void main() {
//   group('PodcastsList', () {
//     late API api;
//     late MockClient mockClient;

//     setUp(() {
//       mockClient = MockClient();
//       api = API(client: mockClient);
//     });

//     testWidgets('displays podcasts correctly', (WidgetTester tester) async {
//       final myApp = MaterialApp(
//         home: Scaffold(
//           body: Provider<API>(
//             create: (_) => api,
//             child: PodcastsList(
//                 podcastsFuture: Future.value(podcastsWithoutImages)),
//           ),
//         ),
//       );

//       await tester.pumpWidget(myApp);
//       expect(find.byType(CircularProgressIndicator), findsOneWidget);

//       await tester.pumpAndSettle();

//       expect(find.byType(CircularProgressIndicator), findsNothing);

//       expect(find.byType(ListTile), findsNWidgets(parsedMockPodcasts.length));
//       expect(find.byIcon(Icons.podcasts),
//           findsNWidgets(parsedMockPodcasts.length));

//       for (var i = 0; i < parsedMockPodcasts.length; i++) {
//         final podcast = parsedMockPodcasts[i];
//         expect(find.text(podcast.podcastName), findsOneWidget);
//         expect(find.text('Podcast ID: ${podcast.podcastId}'), findsOneWidget);
//       }
//     });
//   });
}
