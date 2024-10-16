import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/const.dart';
import 'package:rockserwis_podcaster/components/error_prompt.dart';
import 'package:rockserwis_podcaster/providers/audio_handler_repository.dart';
import 'package:rockserwis_podcaster/providers/objectbox_repository.dart';
import 'package:rockserwis_podcaster/providers/podcast_sync_helper.dart';
import 'package:rockserwis_podcaster/utils/app_theme_data.dart';
import 'package:rockserwis_podcaster/utils/app_theme_mode.dart';
import 'package:rockserwis_podcaster/utils/package_info_provider.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';

part 'app_startup.g.dart';

var logger = Logger();

const _forceRefresh = false;

@riverpod
class AppStartupNotifier extends _$AppStartupNotifier {
  @override
  Future<void> build() async {
    // Preload any other FutureProviders what will be used with requireValue later
    await ref.watch(objectBoxProvider.future);
    await ref.watch(packageInfoProvider.future);
    await ref.watch(audioHandlerProvider.future);

    await _updateDatabaseFromNetwork();
  }

  Future<void> _updateDatabaseFromNetwork() async {
    state = const AsyncValue.loading();

    final sharedPreferences = ref.watch(sharedPreferencesProvider).requireValue;
    final packageInfo = ref.watch(packageInfoProvider).requireValue;

    final lastVersion = sharedPreferences.getString(Const.versionKey);
    final currentVersion = '${packageInfo.version}+${packageInfo.buildNumber}';

    bool shouldUpdateForNewVersion = false;

    if (lastVersion != currentVersion || _forceRefresh) {
      logger.d('Current version: $currentVersion, last version: $lastVersion');

      shouldUpdateForNewVersion = true;

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

      await sharedPreferences.setString(Const.versionKey, currentVersion);
    }

    const cacheDuration = Duration(days: 1);
    final now = DateTime.now();
    final lastUpdatedString = sharedPreferences.getString(Const.lastUpdatedKey);
    final lastUpdated =
        lastUpdatedString != null ? DateTime.parse(lastUpdatedString) : null;

    if (lastUpdated == null ||
        now.difference(lastUpdated) > cacheDuration ||
        shouldUpdateForNewVersion ||
        _forceRefresh) {
      logger.d('Syncing podcasts and episodes');
      await ref.read(podcastSyncHelperProvider).syncAll();

      await sharedPreferences.setString(Const.lastUpdatedKey, now.toString());
    } else {
      logger.d('Cache is still valid');
    }
  }

  Future<void> retry() async {
    state = await AsyncValue.guard(_updateDatabaseFromNetwork);
  }
}

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key, required this.onLoaded});
  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. eagerly initialize appStartupProvider (and all the providers it depends on)
    final appStartupState = ref.watch(appStartupNotifierProvider);

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
            await ref.read(appStartupNotifierProvider.notifier).retry();
          },
        );
      },
      // 5. success - now load the main app
      data: (_) => onLoaded(context),
    );
  }
}

class AppStartupLoadingWidget extends ConsumerWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeNotifierProvider);

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
    final themeMode = ref.watch(appThemeModeNotifierProvider);

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
