import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/screens/episodes.dart';

class PodcastsPage extends StatelessWidget {
  const PodcastsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<API>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Podcasts'),
      ),
      body: FutureBuilder<List<Podcast>>(
          future: apiProvider.getPodcasts(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Podcast currentPodcast = snapshot.data![index];

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: currentPodcast.image != null
                          ? CachedNetworkImage(
                              // Use CachedNetworkImage
                              imageUrl: apiProvider
                                  .getImagePath(currentPodcast.image),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.podcasts),
                      title: Text(
                        currentPodcast.podcastName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Podcast ID: ${currentPodcast.podcastId}'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EpisodesPage(currentPodcast: currentPodcast)),
                        );
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
