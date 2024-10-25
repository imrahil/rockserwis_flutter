import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/components/player_central_button.dart';
import 'package:rockserwis_podcaster/components/progress_bar.dart';
import 'package:rockserwis_podcaster/providers/episode_repository.dart';
import 'package:rockserwis_podcaster/providers/player_repository.dart';

class Player extends ConsumerWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiProvider = ref.watch(apiRepositoryProvider);
    final playerRepository = ref.watch(playerRepositoryProvider);

    final playerRepositoryNotifier =
        ref.read(playerRepositoryProvider.notifier);

    final currentEpisode = playerRepository.currentEpisode;

    if (currentEpisode == null) {
      return Scaffold(
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Nothing to play...'),
              ],
            ),
          ),
        ),
      );
    }

    final isFavorited = ref
            .watch(watchFavoritedEpisodeProvider(currentEpisode.episodeId))
            .valueOrNull ??
        false;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentEpisode.getEpisodeTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: [
            const Spacer(),
            currentEpisode.imgPath != ""
                ? CachedNetworkImage(
                    // Use CachedNetworkImage
                    imageUrl: apiProvider.getImagePath(currentEpisode.imgPath),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : const Spacer(),
            const Spacer(),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () async {
                  await ref
                      .read(allEpisodesProvider.notifier)
                      .toggleFavoriteEpisode(currentEpisode.episodeId);
                },
              ),
            ),
            AudioProgressBar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  iconSize: 34.0,
                  onPressed: ref
                      .read(playerRepositoryProvider.notifier)
                      .skipToPrevious,
                ),
                IconButton(
                  icon: const Icon(Icons.replay_30),
                  iconSize: 36.0,
                  onPressed: playerRepositoryNotifier.rewind,
                ),
                CentralButton(),
                IconButton(
                  icon: const Icon(Icons.forward_30),
                  iconSize: 36.0,
                  onPressed: playerRepositoryNotifier.fastForward,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  iconSize: 34.0,
                  onPressed:
                      ref.read(playerRepositoryProvider.notifier).skipToNext,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
