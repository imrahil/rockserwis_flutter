import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/components/podcasts_list.dart';
import 'package:rockserwis_podcaster/components/shared_app_bar.dart';
import 'package:rockserwis_podcaster/providers/podcast_repository.dart';

class PodcastsPage extends ConsumerStatefulWidget {
  const PodcastsPage({super.key});

  @override
  ConsumerState<PodcastsPage> createState() => _PodcastsPageState();
}

class _PodcastsPageState extends ConsumerState<PodcastsPage> {
  @override
  Widget build(BuildContext context) {
    final podcastsAsync = ref.watch(allPodcastsProvider);

    return Scaffold(
      appBar: SharedAppBar(title: 'Podcasts'),
      body: podcastsAsync.when(
        skipLoadingOnReload: true,
        data: (podcasts) => PodcastsList(podcasts: podcasts),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Error loading podcasts...')),
      ),
    );
  }
}
