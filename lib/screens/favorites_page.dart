import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/screens/episodes_list.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  Future<List<Episode>> fetchEpisodes(context) {
    final apiProvider = Provider.of<API>(context);

    return apiProvider.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return EpisodesList(
        title: "Favorites", episodesFuture: fetchEpisodes(context));
  }
}
