import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/components/episodes_list.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';

class EpisodesPage extends StatefulWidget {
  final Podcast currentPodcast;

  const EpisodesPage({super.key, required this.currentPodcast});

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  late Podcast _currentPodcast;

  @override
  void initState() {
    super.initState();

    _currentPodcast = widget.currentPodcast;
  }

  Future<List<Episode>> fetchEpisodes(context) {
    final apiProvider = Provider.of<API>(context);

    return apiProvider.getEpisodes(_currentPodcast);
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<API>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentPodcast.podcastName),
        actions: [
          FutureBuilder<bool>(
            future: apiProvider.isFavoritePodcast(_currentPodcast),
            builder: (BuildContext context, snapshot) {
              bool isFavorite = false;

              if (snapshot.hasData) {
                isFavorite = snapshot.data ?? false;
              }

              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.bookmark_remove : Icons.bookmark_add,
                ),
                onPressed: () async {
                  await apiProvider.toggleFavoritePodcast(_currentPodcast);
                  setState(() {}); // Rebuild to update icon
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => apiProvider.logout(context),
          ),
        ],
      ),
      body: EpisodesList(
        episodesFuture: fetchEpisodes(context),
      ),
    );
  }
}
