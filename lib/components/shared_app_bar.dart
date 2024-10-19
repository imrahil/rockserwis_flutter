import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/app_routes.dart';
import 'package:rockserwis_podcaster/utils/app_theme_mode.dart';

class SharedAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;

  const SharedAppBar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeNotifierProvider);

    void logout(context) async {
      await ref.read(apiRepositoryProvider).logout();

      while (GoRouter.of(context).canPop() == true) {
        context.pop();
      }

      GoRouter.of(context).go(AppRoutes.login);
    }

    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(
            themeMode.name == 'dark' ? Icons.dark_mode : Icons.light_mode,
          ),
          onPressed: () =>
              ref.read(appThemeModeNotifierProvider.notifier).toggleTheme(),
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => logout(context),
        ),
      ],
    );
  }
}
