import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/app_routes.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/providers/download_repository.dart';
import 'package:rockserwis_podcaster/providers/download_settings.dart';
import 'package:rockserwis_podcaster/providers/player_repository.dart';

class EpisodesList extends StatelessWidget {
  final List<Episode> episodes;
  final Podcast? currentPodcast;
  final Future<void> Function()? onRefresh;

  const EpisodesList({
    super.key,
    required this.episodes,
    this.currentPodcast,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final list = ListView.builder(
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        Episode currentEpisode = episodes[index];

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

    if (onRefresh == null) return list;
    return RefreshIndicator(onRefresh: onRefresh!, child: list);
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
        trailing: Wrap(
          spacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            favoriteIcon,
            _DownloadButton(episode: currentEpisode),
            const Icon(Icons.play_circle),
          ],
        ),
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

class _DownloadButton extends ConsumerWidget {
  const _DownloadButton({required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(downloadSettingsProvider).downloadsEnabled) {
      return const SizedBox.shrink();
    }

    if (episode.downloadedPath != null) {
      return IconButton(
        icon: const Icon(Icons.cloud_done, color: Colors.green),
        tooltip: 'Downloaded — tap to remove',
        onPressed: () => _confirmDelete(context, ref),
      );
    }

    final progressAsync = ref.watch(downloadProgressProvider(episode.episodeId));
    final progress = progressAsync.asData?.value;

    if (progress != null && progress >= 0 && progress < 1) {
      return IconButton(
        icon: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            value: progress > 0 ? progress : null,
            strokeWidth: 2,
          ),
        ),
        tooltip: 'Cancel download',
        onPressed: () => ref
            .read(downloadRepositoryProvider)
            .cancelDownload(episode.episodeId),
      );
    }

    return IconButton(
      icon: const Icon(Icons.download),
      tooltip: 'Download episode',
      onPressed: () =>
          ref.read(downloadRepositoryProvider).downloadEpisode(episode),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove download?'),
        content: Text('Delete the downloaded file for "${episode.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(downloadRepositoryProvider).deleteDownload(episode);
    }
  }
}
