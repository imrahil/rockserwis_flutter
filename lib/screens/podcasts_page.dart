import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/components/podcasts_list.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/screens/favorite_episodes_page.dart';
import 'package:rockserwis_podcaster/screens/favorite_podcasts_page.dart';
import 'package:rockserwis_podcaster/theme.dart';

class PodcastsPage extends StatelessWidget {
  const PodcastsPage({super.key});

  Future<List<Podcast>> fetchPodcasts(context) {
    final apiProvider = Provider.of<API>(context);

    return apiProvider.getPodcasts();
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<API>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Podcasts"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.bookmarks),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritePodcastsPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesEpisodesPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => apiProvider.logout(context),
          ),
        ],
      ),
      body: PodcastsList(
        podcastsFuture: fetchPodcasts(context),
      ),
    );
  }
}
