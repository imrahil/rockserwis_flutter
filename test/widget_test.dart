import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/main.dart';
import 'package:rockserwis_podcaster/screens/login.dart';
import 'package:mockito/mockito.dart';

class MockAPI extends Mock implements API {}

void main() {
  testWidgets('MusicPlayer builds MaterialApp with correct theme',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<API>(create: (_) => MockAPI()),
        ],
        child: const MusicPlayer(homeComp: LoginPage()),
      ),
    );

    // Verify MaterialApp is created
    expect(find.byType(MaterialApp), findsOneWidget);

    // Verify MaterialApp's title
    final MaterialApp app =
        tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.title, 'Rockserwis.fm Podcast Player');

    // Verify MaterialApp's debugShowCheckedModeBanner is false
    expect(app.debugShowCheckedModeBanner, false);

    // Verify ThemeData's brightness is Brightness.dark
    expect(app.theme?.brightness, Brightness.dark);

    // Verify InputDecorationTheme properties
    expect(app.theme?.inputDecorationTheme.filled, true);
    expect(app.theme?.inputDecorationTheme.fillColor, Colors.grey[850]);
    expect(app.theme?.inputDecorationTheme.labelStyle!.color, Colors.grey[400]);
    expect(app.theme?.inputDecorationTheme.border!.borderSide.color,
        Colors.grey[600]);
    expect(app.theme?.inputDecorationTheme.enabledBorder!.borderSide.color,
        Colors.grey[600]);
    expect(app.theme?.inputDecorationTheme.focusedBorder!.borderSide.color,
        Colors.blue);
  });

  testWidgets('MusicPlayer has LoginPage as home', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<API>(create: (_) => MockAPI()),
        ],
        child: const MusicPlayer(
          homeComp: LoginPage(),
        ),
      ),
    );

    // Verify LoginPage is the home
    expect(find.byType(LoginPage), findsOneWidget);
  });
}
