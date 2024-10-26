import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/components/episodes_list.dart';
import 'package:rockserwis_podcaster/providers/episode_repository.dart';

class FavoriteEpisodesPage extends ConsumerWidget {
  const FavoriteEpisodesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritedEpisodesAsync = ref.watch(favoritedEpisodesProvider);

    return Scaffold(
      body: favoritedEpisodesAsync.when(
        skipLoadingOnReload: true,
        data: (episodes) => EpisodesList(episodes: episodes),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Error loading episodes...')),
      ),
    );
  }
}
