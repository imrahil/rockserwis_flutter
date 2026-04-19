import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/app_routes.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';

class PodcastsList extends StatelessWidget {
  final List<Podcast> podcasts;
  final Future<void> Function()? onRefresh;

  const PodcastsList({
    super.key,
    required this.podcasts,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final list = ListView.builder(
      itemCount: podcasts.length,
      itemBuilder: (context, index) {
        Podcast currentPodcast = podcasts[index];

        return PodcastListTile(currentPodcast: currentPodcast);
      },
    );

    if (onRefresh == null) return list;
    return RefreshIndicator(onRefresh: onRefresh!, child: list);
  }
}

class PodcastListTile extends ConsumerWidget {
  const PodcastListTile({
    super.key,
    required this.currentPodcast,
  });

  final Podcast currentPodcast;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiProvider = ref.read(apiRepositoryProvider);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: currentPodcast.image != ""
            ? CachedNetworkImage(
                // Use CachedNetworkImage
                imageUrl: apiProvider.getImagePath(currentPodcast.image),
                placeholder: (context, url) => SizedBox(
                  height: 56.0,
                  width: 56.0,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              )
            : const Icon(Icons.podcasts, size: 56),
        title: Text(
          currentPodcast.podcastName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Podcast ID: ${currentPodcast.podcastId}'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () => context.push(
          '${AppRoutes.podcasts}/${AppRoutes.episodes}',
          extra: currentPodcast,
        ),
      ),
    );
  }
}
