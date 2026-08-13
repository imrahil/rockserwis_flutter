import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/components/episodes_list.dart';
import 'package:rockserwis_podcaster/components/error_prompt.dart';
import 'package:rockserwis_podcaster/providers/episode_repository.dart';
import 'package:rockserwis_podcaster/utils/logger.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyEpisodesAsync = ref.watch(historyEpisodesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            tooltip: 'Clear history',
            onPressed: ref.read(allEpisodesProvider.notifier).resetTimestamp,
          ),
        ],
      ),
      body: historyEpisodesAsync.when(
        skipLoadingOnReload: true,
        data: (episodes) => EpisodesList(
          episodes: episodes,
          onRefresh: () => ref.refresh(historyEpisodesProvider.future),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) {
          logger.e('Error loading history', error: e, stackTrace: st);
          return Center(
            child: ErrorPrompt(
              message: 'Could not load history.',
              onRetry: () => ref.invalidate(historyEpisodesProvider),
            ),
          );
        },
      ),
    );
  }
}
