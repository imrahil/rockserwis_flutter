import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/providers/download_settings.dart';
import 'package:rockserwis_podcaster/utils/app_theme_mode.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  static const _storageOptions = <int, String>{
    250: '250 MB',
    500: '500 MB',
    1024: '1 GB',
    2048: '2 GB',
    5120: '5 GB',
    0: 'Unlimited',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);
    final settings = ref.watch(downloadSettingsProvider);
    final settingsNotifier =
        ref.read(downloadSettingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _SectionHeader(title: 'Appearance'),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Theme'),
            trailing: DropdownButton<ThemeMode>(
              value: themeMode,
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(appThemeModeProvider.notifier).setTheme(mode);
                }
              },
              items: const [
                DropdownMenuItem(
                    value: ThemeMode.system, child: Text('System')),
                DropdownMenuItem(
                    value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
            ),
          ),
          const Divider(),
          _SectionHeader(title: 'Downloads'),
          SwitchListTile(
            secondary: const Icon(Icons.download),
            title: const Text('Enable downloads'),
            value: settings.downloadsEnabled,
            onChanged: settingsNotifier.setDownloadsEnabled,
          ),
          SwitchListTile(
            secondary: const Icon(Icons.wifi),
            title: const Text('Wi-Fi only'),
            subtitle: const Text('Block downloads on cellular network'),
            value: settings.wifiOnly,
            onChanged: settings.downloadsEnabled
                ? settingsNotifier.setWifiOnly
                : null,
          ),
          SwitchListTile(
            secondary: const Icon(Icons.auto_awesome),
            title: const Text('Auto-download new episodes'),
            subtitle: const Text('From favorited podcasts'),
            value: settings.autoDownloadFavorites,
            onChanged: settings.downloadsEnabled
                ? settingsNotifier.setAutoDownloadFavorites
                : null,
          ),
          ListTile(
            leading: const Icon(Icons.sd_storage),
            title: const Text('Max storage'),
            enabled: settings.downloadsEnabled,
            trailing: DropdownButton<int>(
              value: _storageOptions.containsKey(settings.maxStorageMb)
                  ? settings.maxStorageMb
                  : 1024,
              onChanged: settings.downloadsEnabled
                  ? (value) {
                      if (value != null) {
                        settingsNotifier.setMaxStorageMb(value);
                      }
                    }
                  : null,
              items: _storageOptions.entries
                  .map((e) => DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value),
                      ))
                  .toList(),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.delete_sweep),
            title: const Text('Auto-delete after played'),
            value: settings.autoDeleteAfterPlayed,
            onChanged: settings.downloadsEnabled
                ? settingsNotifier.setAutoDeleteAfterPlayed
                : null,
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
