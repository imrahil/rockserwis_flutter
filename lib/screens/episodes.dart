import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/screens/player.dart';

class EpisodesPage extends StatelessWidget {
  final Podcast currentPodcast;

  const EpisodesPage({super.key, required this.currentPodcast});

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<API>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Episodes'),
      ),
      body: FutureBuilder<List<Episode>>(
          future: apiProvider.getEpisodes(currentPodcast),
          builder:
              (BuildContext context, AsyncSnapshot<List<Episode>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Episode currentEpisode = snapshot.data![index];

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: currentEpisode.imgPath != null
                          ? CachedNetworkImage(
                              // Use CachedNetworkImage
                              imageUrl: apiProvider
                                  .getImagePath(currentEpisode.imgPath),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : const Icon(Icons.podcasts),
                      title: Text(
                        currentEpisode.getEpisodeTitle(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Podcast duration: ${currentEpisode.getReadableDuration()}'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        if (currentEpisode.hasPodcast) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Player(currentEpisode: currentEpisode)),
                          );
                        }
                      },
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
