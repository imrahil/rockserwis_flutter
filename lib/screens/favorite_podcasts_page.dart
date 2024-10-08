import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/api/podcast_db_repository.dart';
import 'package:rockserwis_podcaster/components/podcasts_list.dart';

class FavoritePodcastsPage extends ConsumerWidget {
  const FavoritePodcastsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritedPodcastsAsync = ref.watch(favoritedPodcastsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite podcasts"),
      ),
      body: favoritedPodcastsAsync.when(
        data: (podcasts) => PodcastsList(podcasts: podcasts),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Error loading podcasts...')),
      ),
    );
  }
}
