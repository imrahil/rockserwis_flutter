import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/components/podcasts_list.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';

class PodcastsPage extends StatelessWidget {
  const PodcastsPage({super.key});

  Future<List<Podcast>> fetchPodcasts(context) {
    final apiProvider = Provider.of<API>(context);

    return apiProvider.getPodcasts();
  }

  @override
  Widget build(BuildContext context) {
    return PodcastsList(
        title: "Podcasts",
        showFavorites: true,
        podcastsFuture: fetchPodcasts(context));
  }
}
