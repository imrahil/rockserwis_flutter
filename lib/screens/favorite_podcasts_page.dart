import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/components/podcasts_list.dart';
import 'package:rockserwis_podcaster/providers/podcast_repository.dart';

class FavoritePodcastsPage extends ConsumerWidget {
  const FavoritePodcastsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritedPodcastsAsync = ref.watch(favoritedPodcastsProvider);

    return Scaffold(
      body: favoritedPodcastsAsync.when(
        data: (podcasts) => PodcastsList(podcasts: podcasts),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Error loading podcasts...')),
      ),
    );
  }
}
