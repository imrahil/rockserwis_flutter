import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/utils/const.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';

part 'download_settings.g.dart';

class DownloadSettings {
  final bool downloadsEnabled;
  final bool wifiOnly;
  final bool autoDownloadFavorites;
  final int maxStorageMb;
  final bool autoDeleteAfterPlayed;

  const DownloadSettings({
    required this.downloadsEnabled,
    required this.wifiOnly,
    required this.autoDownloadFavorites,
    required this.maxStorageMb,
    required this.autoDeleteAfterPlayed,
  });

  DownloadSettings copyWith({
    bool? downloadsEnabled,
    bool? wifiOnly,
    bool? autoDownloadFavorites,
    int? maxStorageMb,
    bool? autoDeleteAfterPlayed,
  }) {
    return DownloadSettings(
      downloadsEnabled: downloadsEnabled ?? this.downloadsEnabled,
      wifiOnly: wifiOnly ?? this.wifiOnly,
      autoDownloadFavorites:
          autoDownloadFavorites ?? this.autoDownloadFavorites,
      maxStorageMb: maxStorageMb ?? this.maxStorageMb,
      autoDeleteAfterPlayed:
          autoDeleteAfterPlayed ?? this.autoDeleteAfterPlayed,
    );
  }
}

@riverpod
class DownloadSettingsNotifier extends _$DownloadSettingsNotifier {
  @override
  DownloadSettings build() {
    final prefs = ref.watch(sharedPreferencesProvider).requireValue;
    return DownloadSettings(
      downloadsEnabled: prefs.getBool(Const.downloadsEnabledKey) ?? true,
      wifiOnly: prefs.getBool(Const.downloadsWifiOnlyKey) ?? true,
      autoDownloadFavorites:
          prefs.getBool(Const.autoDownloadFavoritesKey) ?? false,
      maxStorageMb: prefs.getInt(Const.maxStorageMbKey) ?? 1024,
      autoDeleteAfterPlayed:
          prefs.getBool(Const.autoDeleteAfterPlayedKey) ?? false,
    );
  }

  Future<void> setDownloadsEnabled(bool value) async {
    final prefs = ref.read(sharedPreferencesProvider).requireValue;
    await prefs.setBool(Const.downloadsEnabledKey, value);
    state = state.copyWith(downloadsEnabled: value);
  }

  Future<void> setWifiOnly(bool value) async {
    final prefs = ref.read(sharedPreferencesProvider).requireValue;
    await prefs.setBool(Const.downloadsWifiOnlyKey, value);
    state = state.copyWith(wifiOnly: value);
  }

  Future<void> setAutoDownloadFavorites(bool value) async {
    final prefs = ref.read(sharedPreferencesProvider).requireValue;
    await prefs.setBool(Const.autoDownloadFavoritesKey, value);
    state = state.copyWith(autoDownloadFavorites: value);
  }

  Future<void> setMaxStorageMb(int value) async {
    final prefs = ref.read(sharedPreferencesProvider).requireValue;
    await prefs.setInt(Const.maxStorageMbKey, value);
    state = state.copyWith(maxStorageMb: value);
  }

  Future<void> setAutoDeleteAfterPlayed(bool value) async {
    final prefs = ref.read(sharedPreferencesProvider).requireValue;
    await prefs.setBool(Const.autoDeleteAfterPlayedKey, value);
    state = state.copyWith(autoDeleteAfterPlayed: value);
  }
}
