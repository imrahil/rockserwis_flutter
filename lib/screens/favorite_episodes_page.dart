import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/api/episode_db_repository.dart';
import 'package:rockserwis_podcaster/components/episodes_list.dart';

class FavoritesEpisodesPage extends ConsumerWidget {
  const FavoritesEpisodesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritedEpisodesAsync = ref.watch(favoritedEpisodesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite episodes"),
      ),
      body: favoritedEpisodesAsync.when(
        data: (episodes) => EpisodesList(episodes: episodes),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Error loading episodes...')),
      ),
    );
  }
}
