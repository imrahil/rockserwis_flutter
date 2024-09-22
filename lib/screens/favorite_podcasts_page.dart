import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/components/podcasts_list.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';

class FavoritePodcastsPage extends StatelessWidget {
  const FavoritePodcastsPage({super.key});

  Future<List<Podcast>> fetchPodcasts(context) {
    final apiProvider = Provider.of<API>(context);

    return apiProvider.getFavoritePodcasts();
  }

  @override
  Widget build(BuildContext context) {
    return PodcastsList(
        title: "Favorite podcasts", podcastsFuture: fetchPodcasts(context));
  }
}
