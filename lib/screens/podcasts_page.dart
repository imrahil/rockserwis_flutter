import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/api/podcast_repository.dart';
import 'package:rockserwis_podcaster/app_routes.dart';
import 'package:rockserwis_podcaster/components/podcasts_list.dart';
import 'package:rockserwis_podcaster/utils/app_theme_mode.dart';

class PodcastsPage extends ConsumerStatefulWidget {
  const PodcastsPage({super.key});

  @override
  ConsumerState<PodcastsPage> createState() => _PodcastsPageState();
}

class _PodcastsPageState extends ConsumerState<PodcastsPage> {
  void logout(context) async {
    //   final apiProvider = Provider.of<API>(context, listen: false);

    //   await apiProvider.logout();

    //   if (context.mounted) {
    //     Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const LoginPage(),
    //       ),
    //       (Route<dynamic> route) => false,
    //     );
    //   }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(appThemeModeNotifierProvider);
    final podcastsAsync = ref.watch(fetchPodcastsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Podcasts"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // This will rebuild the widget and fetch the podcasts again
              // FIXME
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(
              themeMode.name == 'dark' ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () =>
                ref.read(appThemeModeNotifierProvider.notifier).toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.bookmarks),
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.favoritedPodcasts),
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.favoritedEpisodes),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: podcastsAsync.when(
        data: (podcasts) => PodcastsList(podcasts: podcasts),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Error loading podcasts...')),
      ),
    );
  }
}
