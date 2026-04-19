import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/app_routes.dart';

class SharedAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;

  const SharedAppBar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          icon: const Icon(Icons.settings),
          tooltip: 'Settings',
          onPressed: () => context.push(AppRoutes.settings),
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Log out',
          onPressed: () => logout(context),
        ),
      ],
    );
  }
}
