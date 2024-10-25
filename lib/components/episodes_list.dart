import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/app_routes.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/providers/player_repository.dart';

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

        // Check if the episode has an image, if not, use the podcast image
        // side-effect: the image property will be saved to the database
        if (currentEpisode.imgPath == "" &&
            currentPodcast != null &&
            currentPodcast?.image != "") {
          currentEpisode =
              currentEpisode.copyWith(imgPath: currentPodcast!.image);
        }

        return EpisodeListTile(
          currentEpisode: currentEpisode,
          episodes: episodes,
        );
      },
    );
  }
}

class EpisodeListTile extends ConsumerWidget {
  const EpisodeListTile({
    super.key,
    required this.episodes,
    required this.currentEpisode,
  });

  final List<Episode> episodes;
  final Episode currentEpisode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiProvider = ref.read(apiRepositoryProvider);
    final favoriteIcon = currentEpisode.isFavorited
        ? Icon(Icons.favorite, color: const Color.fromARGB(255, 189, 69, 60))
        : SizedBox.shrink();

    final playerRepositoryNotifier =
        ref.read(playerRepositoryProvider.notifier);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: currentEpisode.imgPath != ""
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
            : const Icon(Icons.podcasts, size: 56),
        title: Text(
          currentEpisode.getEpisodeTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Text('Duration: ${currentEpisode.getReadableDuration}'),
            SizedBox(width: 10),
            currentEpisode.progress > 0 && currentEpisode.total > 0
                ? Expanded(
                    child: LinearProgressIndicator(
                      value: currentEpisode.progress / currentEpisode.total,
                    ),
                  )
                : Spacer(),
            SizedBox(width: 10),
          ],
        ),
        trailing: Wrap(spacing: 12, children: [
          favoriteIcon,
          const Icon(Icons.play_circle),
        ]),
        onTap: () {
          if (currentEpisode.hasPodcast) {
            playerRepositoryNotifier.setEpisodes(episodes);
            playerRepositoryNotifier.setAudioSource(currentEpisode);

            context.go(AppRoutes.player);
          }
        },
      ),
    );
  }
}
