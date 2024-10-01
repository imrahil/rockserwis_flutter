import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_theme_mode.g.dart';

/// A notifier used to read and write the themeMode to SharedPreferences
@riverpod
class AppThemeModeNotifier extends _$AppThemeModeNotifier {
  static const key = 'app_theme_mode';

  SharedPreferences get _sharedPreferences =>
      ref.watch(sharedPreferencesProvider).requireValue;

  @override
  ThemeMode build() {
    final themeModeStr = _sharedPreferences.getString(key);

    return switch (themeModeStr) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' || _ => ThemeMode.system,
    };
  }

  void toggleTheme() {
    final themeModeStr = _sharedPreferences.getString(key);

    String newTheme = themeModeStr == 'dark' ? 'light' : 'dark';
    _sharedPreferences.setString(key, newTheme);

    ref.invalidateSelf();
  }
}
