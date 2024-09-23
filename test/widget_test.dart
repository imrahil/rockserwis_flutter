import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/main.dart';
import 'package:rockserwis_podcaster/screens/login.dart';
import 'package:mockito/mockito.dart';
import 'package:rockserwis_podcaster/theme.dart';

class MockAPI extends Mock implements API {}

void main() {
  testWidgets('MusicPlayer builds MaterialApp with correct theme',
      (WidgetTester tester) async {
    // Create a ThemeProvider and set it to dark mode
    final themeProvider = ThemeProvider();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<API>(create: (_) => MockAPI()),
          ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ],
        child: const MusicPlayer(homeComp: LoginPage()),
      ),
    );

    // Verify MaterialApp is created
    expect(find.byType(MaterialApp), findsOneWidget);

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(app.title, 'Rockserwis.fm Podcast Player');
    expect(app.debugShowCheckedModeBanner, false);
    expect(app.theme?.brightness, Brightness.dark);

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

  // Add a similar test for light mode
  testWidgets('MusicPlayer builds MaterialApp with correct light theme',
      (WidgetTester tester) async {
    final themeProvider = ThemeProvider();
    themeProvider.toggleTheme();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<API>(create: (_) => MockAPI()),
          ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ],
        child: const MusicPlayer(homeComp: LoginPage()),
      ),
    );

    // Verify MaterialApp is created
    expect(find.byType(MaterialApp), findsOneWidget);

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(app.theme?.brightness, Brightness.light);
    expect(app.theme?.inputDecorationTheme.filled, true);
    expect(app.theme?.inputDecorationTheme.fillColor, Colors.grey[200]);
    expect(app.theme?.inputDecorationTheme.labelStyle!.color, Colors.grey[700]);
    expect(app.theme?.inputDecorationTheme.border!.borderSide.color,
        Colors.grey[400]);
    expect(app.theme?.inputDecorationTheme.enabledBorder!.borderSide.color,
        Colors.grey[400]);
    expect(app.theme?.inputDecorationTheme.focusedBorder!.borderSide.color,
        Colors.blue);
  });

  testWidgets('MusicPlayer has LoginPage as home', (WidgetTester tester) async {
    final themeProvider = ThemeProvider();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<API>(create: (_) => MockAPI()),
          ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
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
