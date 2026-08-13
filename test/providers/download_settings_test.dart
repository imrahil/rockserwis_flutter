import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rockserwis_podcaster/providers/download_settings.dart';
import 'package:rockserwis_podcaster/utils/const.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _buildContainer(Map<String, Object> initial) async {
  SharedPreferences.setMockInitialValues(initial);
  final prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWith((ref) async => prefs),
    ],
  );
  addTearDown(container.dispose);
  await container.read(sharedPreferencesProvider.future);
  return container;
}

void main() {
  group('DownloadSettingsNotifier', () {
    test('defaults match the documented defaults when nothing is saved',
        () async {
      final container = await _buildContainer({});
      final settings = container.read(downloadSettingsProvider);

      expect(settings.downloadsEnabled, true);
      expect(settings.wifiOnly, true);
      expect(settings.autoDownloadFavorites, false);
      expect(settings.maxStorageMb, 1024);
      expect(settings.autoDeleteAfterPlayed, false);
    });

    test('reads previously saved values from prefs', () async {
      final container = await _buildContainer({
        Const.downloadsEnabledKey: false,
        Const.downloadsWifiOnlyKey: false,
        Const.autoDownloadFavoritesKey: true,
        Const.maxStorageMbKey: 512,
        Const.autoDeleteAfterPlayedKey: true,
      });
      final settings = container.read(downloadSettingsProvider);

      expect(settings.downloadsEnabled, false);
      expect(settings.wifiOnly, false);
      expect(settings.autoDownloadFavorites, true);
      expect(settings.maxStorageMb, 512);
      expect(settings.autoDeleteAfterPlayed, true);
    });

    test('setAutoDownloadFavorites updates state and persists the value',
        () async {
      final container = await _buildContainer({});
      final notifier = container.read(downloadSettingsProvider.notifier);

      await notifier.setAutoDownloadFavorites(true);

      expect(
        container.read(downloadSettingsProvider).autoDownloadFavorites,
        true,
      );
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(Const.autoDownloadFavoritesKey), true);
    });

    test('setMaxStorageMb updates state and persists the value', () async {
      final container = await _buildContainer({});
      final notifier = container.read(downloadSettingsProvider.notifier);

      await notifier.setMaxStorageMb(2048);

      expect(container.read(downloadSettingsProvider).maxStorageMb, 2048);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt(Const.maxStorageMbKey), 2048);
    });

    test('updating one setting leaves the others untouched', () async {
      final container = await _buildContainer({});
      final notifier = container.read(downloadSettingsProvider.notifier);

      await notifier.setWifiOnly(false);

      final settings = container.read(downloadSettingsProvider);
      expect(settings.wifiOnly, false);
      expect(settings.downloadsEnabled, true);
      expect(settings.autoDownloadFavorites, false);
    });
  });
}
