import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/utils/const.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_theme_mode.g.dart';

/// A notifier used to read and write the themeMode to SharedPreferences
@riverpod
class AppThemeModeNotifier extends _$AppThemeModeNotifier {
  SharedPreferences get _sharedPreferences =>
      ref.watch(sharedPreferencesProvider).requireValue;

  @override
  ThemeMode build() {
    final sharedThemeModeStr =
        _sharedPreferences.getString(Const.appThemeModeKey);

    String themeMode;

    if (sharedThemeModeStr != null) {
      themeMode = sharedThemeModeStr;
    } else {
      themeMode = isDarkMode() ? 'dark' : 'light';
    }

    return themeMode == 'light' ? ThemeMode.light : ThemeMode.dark;
  }

  void toggleTheme() {
    final sharedThemeModeStr =
        _sharedPreferences.getString(Const.appThemeModeKey);

    String newTheme;
    if (sharedThemeModeStr != null) {
      newTheme = sharedThemeModeStr == 'dark' ? 'light' : 'dark';
    } else {
      newTheme = isDarkMode() ? 'light' : 'dark';
    }

    _sharedPreferences.setString(Const.appThemeModeKey, newTheme);

    ref.invalidateSelf();
  }

  /// Returns true if the platform is in dark mode - when "system" is used
  bool isDarkMode() {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return isDarkMode;
  }
}
