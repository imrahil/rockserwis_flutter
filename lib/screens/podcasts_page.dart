import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/utils/app_theme_mode.dart';

class PodcastsPage extends ConsumerStatefulWidget {
  const PodcastsPage({super.key});

  @override
  ConsumerState<PodcastsPage> createState() => _PodcastsPageState();
}

class _PodcastsPageState extends ConsumerState<PodcastsPage> {
  // Future<List<Podcast>> fetchPodcasts(context) {
  //   final apiProvider = Provider.of<API>(context);

  //   return apiProvider.getPodcasts();
  // }

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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Podcasts"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // This will rebuild the widget and fetch the podcasts again
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
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const FavoritePodcastsPage(),
              //   ),
              // );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const FavoritesEpisodesPage(),
              //   ),
              // );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      // body: PodcastsList(
      //   podcastsFuture: fetchPodcasts(context),
      // ),
      body: Container(),
    );
  }
}
