import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rockserwis_podcaster/utils/app_theme_mode.dart';
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
  group('AppThemeModeNotifier', () {
    test('defaults to system when nothing is saved', () async {
      final container = await _buildContainer({});
      expect(container.read(appThemeModeProvider), ThemeMode.system);
    });

    test('reads saved light theme from prefs', () async {
      final container = await _buildContainer({
        Const.appThemeModeKey: 'light',
      });
      expect(container.read(appThemeModeProvider), ThemeMode.light);
    });

    test('reads saved dark theme from prefs', () async {
      final container = await _buildContainer({
        Const.appThemeModeKey: 'dark',
      });
      expect(container.read(appThemeModeProvider), ThemeMode.dark);
    });

    test('setTheme updates state and persists the value', () async {
      final container = await _buildContainer({});

      await container
          .read(appThemeModeProvider.notifier)
          .setTheme(ThemeMode.dark);

      expect(container.read(appThemeModeProvider), ThemeMode.dark);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(Const.appThemeModeKey), 'dark');
    });
  });
}
