import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/components/podcasts_list.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/screens/favorite_episodes_page.dart';
import 'package:rockserwis_podcaster/screens/favorite_podcasts_page.dart';
import 'package:rockserwis_podcaster/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PodcastsPage extends StatelessWidget {
  const PodcastsPage({super.key});

  Future<List<Podcast>> fetchPodcasts(context) {
    final apiProvider = Provider.of<API>(context);

    return apiProvider.getPodcasts();
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', false);
    await prefs.remove('masterCookie');
    await prefs.remove('sessionCookie');

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Podcasts"),
        automaticallyImplyLeading: false,
        actions: [
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
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: PodcastsList(
        podcastsFuture: fetchPodcasts(context),
      ),
    );
  }
}
