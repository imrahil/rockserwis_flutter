import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/components/episodes_list.dart';
import 'package:rockserwis_podcaster/models/episode.dart';

class FavoritesEpisodesPage extends StatelessWidget {
  const FavoritesEpisodesPage({super.key});

  Future<List<Episode>> fetchFavoriteEpisodes(context) {
    final apiProvider = Provider.of<API>(context);

    return apiProvider.getFavoriteEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite episodes"),
      ),
      body: EpisodesList(
        episodesFuture: fetchFavoriteEpisodes(context),
      ),
    );
  }
}
