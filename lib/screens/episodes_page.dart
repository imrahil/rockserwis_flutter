import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/components/episodes_list.dart';

class EpisodesPage extends StatelessWidget {
  final Podcast currentPodcast;

  const EpisodesPage({super.key, required this.currentPodcast});

  Future<List<Episode>> fetchEpisodes(context) {
    final apiProvider = Provider.of<API>(context);

    return apiProvider.getEpisodes(currentPodcast);
  }

  @override
  Widget build(BuildContext context) {
    return EpisodesList(
        title: "Episodes",
        showFavorites: true,
        episodesFuture: fetchEpisodes(context));
  }
}
