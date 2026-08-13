// Runs the real app on a device/emulator, exercising the parts unit tests
// can't reach: Firebase init, the real ObjectBox native store, and the
// AppStartupWidget lifecycle-resume path added to fix auto-download
// reliability. Run with:
//   flutter test integration_test/app_startup_test.dart -d <device-id>
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rockserwis_podcaster/main.dart' as app;
import 'package:rockserwis_podcaster/screens/login_page.dart';
import 'package:rockserwis_podcaster/screens/podcasts_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'app boots past the startup sync gate and survives a background resume',
    (tester) async {
      app.main();

      // Startup does a real Firebase/ObjectBox init and a real network sync
      // (or gracefully skips it if the emulator has no connectivity) —
      // poll instead of a single pumpAndSettle, which can time out on I/O.
      bool reachedHomeScreen() =>
          find.byType(LoginPage).evaluate().isNotEmpty ||
          find.byType(PodcastsPage).evaluate().isNotEmpty;

      for (var i = 0; i < 30 && !reachedHomeScreen(); i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(
        reachedHomeScreen(),
        isTrue,
        reason: 'App should reach the login or podcasts screen instead of '
            'getting stuck on the startup loading/error screen.',
      );

      // A sync failure (e.g. flaky network) must not block the app behind
      // the full-screen error prompt — cached/local data should still load.
      expect(
        find.text('Could not load or sync data.\nCheck your Internet connection.'),
        findsNothing,
      );

      // Simulate the app being backgrounded and resumed. This exercises
      // AppStartupWidget's WidgetsBindingObserver, which re-checks for new
      // episodes on resume (checkForUpdatesInBackground) instead of only
      // ever syncing once at cold start.
      final binding = tester.binding;
      binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      await tester.pump();
      binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();
      await tester.pump(const Duration(seconds: 2));

      // The background resume check must stay silent — it must not flash
      // the full-screen "Syncing data..." loading UI over the current
      // screen the way a foreground retry would.
      expect(find.text('Syncing data...'), findsNothing);
      expect(reachedHomeScreen(), isTrue);
    },
  );
}
