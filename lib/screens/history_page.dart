import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/components/episodes_list.dart';
import 'package:rockserwis_podcaster/components/shared_app_bar.dart';
import 'package:rockserwis_podcaster/providers/episode_repository.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyEpisodesAsync = ref.watch(episodeHistoryListProvider);

    return Scaffold(
      appBar: SharedAppBar(title: 'History'),
      body: historyEpisodesAsync.when(
        data: (historyItems) => EpisodesList(
            episodes:
                historyItems.map((item) => item.episode.target!).toList()),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Error loading episodes...')),
      ),
    );
  }
}
