import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/app_routes.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';

class EpisodesList extends StatelessWidget {
  final List<Episode> episodes;
  final Podcast? currentPodcast;

  const EpisodesList({
    super.key,
    required this.episodes,
    this.currentPodcast,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        Episode currentEpisode = episodes[index];

        /// Check if the episode has an image, if not, use the podcast image
        if ((currentEpisode.imgPath == null || currentEpisode.imgPath == "") &&
            currentPodcast != null &&
            ![null, ""].contains(currentPodcast?.image)) {
          currentEpisode.imgPath = currentPodcast?.image;
        }

        return EpisodeListTile(currentEpisode: currentEpisode);
      },
    );
  }
}

class EpisodeListTile extends ConsumerWidget {
  const EpisodeListTile({
    super.key,
    required this.currentEpisode,
  });

  final Episode currentEpisode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiProvider = ref.read(apiRepositoryProvider);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: currentEpisode.imgPath != null && currentEpisode.imgPath != ""
            ? CachedNetworkImage(
                // Use CachedNetworkImage
                imageUrl: apiProvider.getImagePath(currentEpisode.imgPath),
                placeholder: (context, url) => SizedBox(
                  height: 56.0,
                  width: 56.0,
                  child: const Center(child: CircularProgressIndicator()),
                ),
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
        onTap: () => {
          if (currentEpisode.hasPodcast)
            {
              Navigator.of(context)
                  .pushNamed(AppRoutes.player, arguments: currentEpisode)
            }
        },
      ),
    );
  }
}
