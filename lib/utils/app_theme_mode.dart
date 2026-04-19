import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/utils/const.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';

part 'app_theme_mode.g.dart';

@riverpod
class AppThemeModeNotifier extends _$AppThemeModeNotifier {
  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider).requireValue;
    final saved = prefs.getString(Const.appThemeModeKey);

    switch (saved) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    final prefs = ref.read(sharedPreferencesProvider).requireValue;
    await prefs.setString(Const.appThemeModeKey, mode.name);
    state = mode;
  }
}
