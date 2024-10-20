import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/app_routes.dart';
import 'package:rockserwis_podcaster/app_startup.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/screens/episodes_page.dart';
import 'package:rockserwis_podcaster/screens/favorite_episodes_page.dart';
import 'package:rockserwis_podcaster/screens/history_page.dart';
import 'package:rockserwis_podcaster/screens/login_page.dart';
import 'package:rockserwis_podcaster/screens/player.dart';
import 'package:rockserwis_podcaster/screens/podcasts_page.dart';
import 'package:rockserwis_podcaster/utils/app_theme_data.dart';
import 'package:rockserwis_podcaster/utils/app_theme_mode.dart';
import 'package:rockserwis_podcaster/utils/scaffold.dart';
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

  final container = ProviderContainer();

  // * Preload SharedPreferences before calling runApp, as the AppStartupWidget
  // * depends on it in order to load the themeMode
  await container.read(sharedPreferencesProvider.future);

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
final _shellNavigatorPodcastsKey = GlobalKey<NavigatorState>();
final _shellNavigatorFavoritesKey = GlobalKey<NavigatorState>();
final _shellNavigatorHistoryKey = GlobalKey<NavigatorState>();

class MusicPlayer extends ConsumerStatefulWidget {
  const MusicPlayer({super.key});
  @override
  ConsumerState<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends ConsumerState<MusicPlayer> {
  late RouterConfig<Object> _routerConfig;

  @override
  void initState() {
    super.initState();

    final isLogged = ref.read(apiRepositoryProvider).isLogged();

    _routerConfig = GoRouter(
      initialLocation: isLogged ? AppRoutes.podcasts : AppRoutes.login,
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          path: AppRoutes.login,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (BuildContext context, GoRouterState state) =>
              const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.player,
          name: AppRoutes.player,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (BuildContext context, GoRouterState state) {
            final (currentEpisode, episodes) = state.extra as PlayerData;
            return Player(currentEpisode: currentEpisode, episodes: episodes);
          },
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNestedNavigation(
              navigationShell: navigationShell,
            );
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _shellNavigatorPodcastsKey,
              routes: [
                GoRoute(
                  path: AppRoutes.podcasts,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: PodcastsPage(),
                  ),
                  routes: [
                    GoRoute(
                      path: AppRoutes.episodes,
                      builder: (context, state) {
                        Podcast currentPodcast = state.extra as Podcast;
                        return EpisodesPage(currentPodcast: currentPodcast);
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorFavoritesKey,
              routes: [
                GoRoute(
                  path: '/favorites',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: FavoritesEpisodesPage(),
                  ),
                  // FIXME - add favorite podcasts/episodes
                  // routes: [
                  //   GoRoute(
                  //     path: 'details',
                  //     builder: (context, state) =>
                  //         const DetailsScreen(label: 'B'),
                  //   ),
                  // ],
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorHistoryKey,
              routes: [
                GoRoute(
                  path: AppRoutes.history,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: HistoryPage(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(appThemeModeNotifierProvider);

    return MaterialApp.router(
      title: 'Rockserwis.fm Podcast Player',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: _routerConfig,
    );
  }
}
