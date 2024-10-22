import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/screens/favorite_episodes_page.dart';
import 'package:rockserwis_podcaster/screens/favorite_podcasts_page.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Podcasts',
                icon: Icon(Icons.bookmarks),
              ),
              Tab(
                text: 'Episodes',
                icon: Icon(Icons.favorite),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          FavoritePodcastsPage(),
          FavoriteEpisodesPage(),
        ]),
      ),
    );
  }
}
