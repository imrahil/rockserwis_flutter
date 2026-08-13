import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/components/episodes_list.dart';
import 'package:rockserwis_podcaster/components/error_prompt.dart';
import 'package:rockserwis_podcaster/providers/episode_repository.dart';
import 'package:rockserwis_podcaster/utils/logger.dart';

class FavoriteEpisodesPage extends ConsumerWidget {
  const FavoriteEpisodesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritedEpisodesAsync = ref.watch(favoritedEpisodesProvider);

    return Scaffold(
      body: favoritedEpisodesAsync.when(
        skipLoadingOnReload: true,
        data: (episodes) => EpisodesList(
          episodes: episodes,
          onRefresh: () => ref.refresh(favoritedEpisodesProvider.future),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) {
          logger.e('Error loading favorite episodes', error: e, stackTrace: st);
          return Center(
            child: ErrorPrompt(
              message: 'Could not load favorite episodes.',
              onRetry: () => ref.invalidate(favoritedEpisodesProvider),
            ),
          );
        },
      ),
    );
  }
}
