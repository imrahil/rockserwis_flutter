import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/components/error_prompt.dart';
import 'package:rockserwis_podcaster/components/podcasts_list.dart';
import 'package:rockserwis_podcaster/providers/podcast_repository.dart';
import 'package:rockserwis_podcaster/utils/logger.dart';

class FavoritePodcastsPage extends ConsumerWidget {
  const FavoritePodcastsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritedPodcastsAsync = ref.watch(favoritedPodcastsProvider);

    return Scaffold(
      body: favoritedPodcastsAsync.when(
        skipLoadingOnReload: true,
        data: (podcasts) => PodcastsList(
          podcasts: podcasts,
          onRefresh: () => ref.refresh(favoritedPodcastsProvider.future),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) {
          logger.e('Error loading favorite podcasts', error: e, stackTrace: st);
          return Center(
            child: ErrorPrompt(
              message: 'Could not load favorite podcasts.',
              onRetry: () => ref.invalidate(favoritedPodcastsProvider),
            ),
          );
        },
      ),
    );
  }
}
