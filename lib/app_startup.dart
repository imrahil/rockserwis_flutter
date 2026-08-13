import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/components/error_prompt.dart';
import 'package:rockserwis_podcaster/providers/audio_service.dart';
import 'package:rockserwis_podcaster/providers/download_repository.dart';
import 'package:rockserwis_podcaster/providers/objectbox_repository.dart';
import 'package:rockserwis_podcaster/providers/podcast_sync_helper.dart';
import 'package:rockserwis_podcaster/utils/app_theme_data.dart';
import 'package:rockserwis_podcaster/utils/app_theme_mode.dart';
import 'package:rockserwis_podcaster/utils/const.dart';
import 'package:rockserwis_podcaster/utils/logger.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';

part 'app_startup.g.dart';

// Local variable to clean the internal database
const _forceRefresh = false;

@riverpod
class AppStartupNotifier extends _$AppStartupNotifier {
  @override
  Future<void> build() async {
    // Preload any other FutureProviders what will be used with requireValue later
    await ref.watch(objectBoxProvider.future);
    await ref.watch(audioServiceProvider.future);

    await _updateDatabaseFromNetwork();
  }

  Future<void> _updateDatabaseFromNetwork() async {
    state = const AsyncValue.loading();
    await _syncIfNeeded();
  }

  /// Runs the podcast/episode sync (and auto-download) if the cache has
  /// expired, without touching [state] — safe to call from a background
  /// resume check without flashing the full-screen loading UI.
  Future<void> _syncIfNeeded() async {
    final sharedPreferences = ref.watch(sharedPreferencesProvider).requireValue;

    if (_forceRefresh) {
      logger.d('Force refresh! Cleaning everything!');

      await ref
          .read(objectBoxProvider)
          .requireValue
          .podcastBox
          .removeAllAsync();
      await ref
          .read(objectBoxProvider)
          .requireValue
          .episodeBox
          .removeAllAsync();
    }

    const cacheDuration = Duration(days: 1);
    final now = DateTime.now();
    final lastUpdatedString = sharedPreferences.getString(Const.lastUpdatedKey);
    final lastUpdated =
        lastUpdatedString != null ? DateTime.parse(lastUpdatedString) : null;

    final cacheExpired = _forceRefresh ||
        lastUpdated == null ||
        now.difference(lastUpdated) > cacheDuration;

    if (!cacheExpired) {
      logger.d('Cache is still valid');
      return;
    }

    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity.contains(ConnectivityResult.none)) {
      logger.d('No internet connection — using offline data');
      return;
    }

    // Sync failures (e.g. no real internet despite a live network
    // connection, or a flaky server) must not block the app — cached/local
    // data and downloaded episodes should still be usable offline.
    try {
      logger.d('Syncing podcasts and episodes');
      final newFavoritedEpisodes =
          await ref.read(podcastSyncHelperProvider).syncAll();

      await sharedPreferences.setString(Const.lastUpdatedKey, now.toString());

      if (newFavoritedEpisodes.isNotEmpty) {
        await ref
            .read(downloadRepositoryProvider)
            .autoDownloadEpisodes(newFavoritedEpisodes);
      }
    } catch (e, st) {
      logger.w('Sync failed, continuing with offline data',
          error: e, stackTrace: st);
    }
  }

  Future<void> retry() async {
    state = await AsyncValue.guard(_updateDatabaseFromNetwork);
  }

  /// Re-checks for new episodes when the app is resumed from the
  /// background. Reuses the same cache-expiry gate as startup, so it's a
  /// no-op most of the time, but ensures the check actually gets a chance
  /// to run for users who resume the app instead of cold-starting it.
  Future<void> checkForUpdatesInBackground() async {
    try {
      await _syncIfNeeded();
    } catch (e, st) {
      logger.e('Background update check failed', error: e, stackTrace: st);
    }
  }
}

class AppStartupWidget extends ConsumerStatefulWidget {
  const AppStartupWidget({super.key, required this.onLoaded});
  final WidgetBuilder onLoaded;

  @override
  ConsumerState<AppStartupWidget> createState() => _AppStartupWidgetState();
}

class _AppStartupWidgetState extends ConsumerState<AppStartupWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(appStartupProvider.notifier).checkForUpdatesInBackground();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. eagerly initialize appStartupProvider (and all the providers it depends on)
    final appStartupState = ref.watch(appStartupProvider);

    return appStartupState.when(
      // 2. loading state
      loading: () => const AppStartupLoadingWidget(),
      // 3. error state
      error: (e, st) {
        logger.d(e);

        return AppStartupErrorWidget(
          message:
              'Could not load or sync data.\nCheck your Internet connection.',
          // 4. invalidate the appStartupProvider
          onRetry: () async {
            await ref.read(appStartupProvider.notifier).retry();
          },
        );
      },
      // 5. success - now load the main app
      data: (_) => widget.onLoaded(context),
    );
  }
}

class AppStartupLoadingWidget extends ConsumerWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: Scaffold(
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Syncing data...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppStartupErrorWidget extends ConsumerWidget {
  const AppStartupErrorWidget(
      {super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ErrorPrompt(
              message: message,
              onRetry: onRetry,
            ),
          ),
        ),
      ),
    );
  }
}
