import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/screens/player.dart';

class EpisodesList extends StatelessWidget {
  final Future<List<Episode>> episodesFuture;
  final Podcast? currentPodcast;

  const EpisodesList({
    super.key,
    required this.episodesFuture,
    this.currentPodcast,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Episode>>(
      future: episodesFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Episode>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Episode currentEpisode = snapshot.data![index];

              /// Check if the episode has an image, if not, use the podcast image
              if ((currentEpisode.imgPath == null ||
                      currentEpisode.imgPath == "") &&
                  currentPodcast != null &&
                  ![null, ""].contains(currentPodcast?.image)) {
                currentEpisode.imgPath = currentPodcast?.image;
              }

              return EpisodeListTile(currentEpisode: currentEpisode);
            },
          );
        }
      },
    );
  }
}

class EpisodeListTile extends StatelessWidget {
  const EpisodeListTile({
    super.key,
    required this.currentEpisode,
  });

  final Episode currentEpisode;

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<API>(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: currentEpisode.imgPath != null && currentEpisode.imgPath != ""
            ? CachedNetworkImage(
                // Use CachedNetworkImage
                imageUrl: apiProvider.getImagePath(currentEpisode.imgPath),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : const Icon(Icons.podcasts),
        title: Text(
          currentEpisode.getEpisodeTitle(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle:
            Text('Podcast duration: ${currentEpisode.getReadableDuration()}'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          if (currentEpisode.hasPodcast) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Player(currentEpisode: currentEpisode),
              ),
            );
          }
        },
      ),
    );
  }
}
