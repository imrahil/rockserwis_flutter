import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/app_routes.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';

class PodcastsList extends StatelessWidget {
  final List<Podcast> podcasts;

  const PodcastsList({
    super.key,
    required this.podcasts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: podcasts.length,
      itemBuilder: (context, index) {
        Podcast currentPodcast = podcasts[index];

        return PodcastListTile(currentPodcast: currentPodcast);
      },
    );
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
        leading: currentPodcast.image != null && currentPodcast.image != ""
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
            : const Icon(Icons.podcasts),
        title: Text(
          currentPodcast.podcastName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Podcast ID: ${currentPodcast.podcastId}'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () => Navigator.of(context)
            .pushNamed(AppRoutes.episodes, arguments: currentPodcast),
      ),
    );
  }
}
