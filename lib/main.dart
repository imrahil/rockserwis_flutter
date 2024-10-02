import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rockserwis_podcaster/app_routes.dart';
import 'package:rockserwis_podcaster/app_startup.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/screens/episodes_page.dart';
import 'package:rockserwis_podcaster/screens/podcasts_page.dart';
import 'package:rockserwis_podcaster/utils/app_theme_data.dart';
import 'package:rockserwis_podcaster/utils/app_theme_mode.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';

import 'utils/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization & settings
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  // -- Firebase

  // final prefs = await SharedPreferences.getInstance();
  // bool rememberMe = prefs.getBool('rememberMe') ?? false;

  // Provider provider = Provider<API>(create: (_) => API(client: http.Client()));

  // if (rememberMe) {
  //   String masterCookie = prefs.getString('masterCookie') ?? "";
  //   String sessionCookie = prefs.getString('sessionCookie') ?? "";

  //   if (masterCookie != "" && sessionCookie != "") {
  //     provider = Provider<API>(
  //         create: (_) => API(
  //             client: http.Client(),
  //             masterCookie: masterCookie,
  //             sessionCookie: sessionCookie));
  //   }
  // }

  // Widget homeComp = !rememberMe ? const LoginPage() : const PodcastsPage();

  final container = ProviderContainer();

  // * Preload SharedPreferences before calling runApp, as the AppStartupWidget
  // * depends on it in order to load the themeMode
  await container.read(sharedPreferencesProvider.future);

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.imrahil.rockserwis.podcaster',
    androidNotificationChannelName: 'Rockserwis.fm Podcast Player',
    androidNotificationOngoing: true,
  );

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: AppStartupWidget(
        onLoaded: (context) => const MusicPlayer(),
      ),
    ),
  );
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeNotifierProvider);

    return MaterialApp(
      title: 'Rockserwis.fm Podcast Player',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      navigatorKey: _rootNavigatorKey,
      onGenerateRoute: (settings) {
        return switch (settings.name) {
          AppRoutes.podcasts => MaterialPageRoute(
              settings: settings,
              builder: (_) => const PodcastsPage(),
            ),
          AppRoutes.episodes => MaterialPageRoute(
              settings: settings,
              builder: (_) {
                final currentPodcast = settings.arguments as Podcast;
                return EpisodesPage(currentPodcast: currentPodcast);
              },
            ),
          _ =>
            throw UnimplementedError('Route named ${settings.name} not found'),
        };
      },
      initialRoute: AppRoutes.podcasts,
    );
  }
}
