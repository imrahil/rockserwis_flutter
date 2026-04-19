import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

    if (saved == 'light') return ThemeMode.light;
    if (saved == 'dark') return ThemeMode.dark;
    return _systemIsDark() ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleTheme() async {
    final prefs = ref.read(sharedPreferencesProvider).requireValue;
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await prefs.setString(Const.appThemeModeKey, next.name);
    state = next;
  }

  bool _systemIsDark() =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
      Brightness.dark;
}
