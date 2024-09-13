import 'package:flutter/material.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/screens/episodes.dart';

class PodcastsPage extends StatelessWidget {
  final API apiProvider;

  const PodcastsPage({super.key, required this.apiProvider});

  @override
  Widget build(BuildContext context) {
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
                  Podcast currentEntry = snapshot.data![index];

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: currentEntry.image != null
                          ? Image.network(
                              apiProvider.getImagePath(currentEntry.image))
                          : const Icon(Icons.podcasts),
                      title: Text(
                        currentEntry.podcastName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Podcast ID: ${currentEntry.podcastId}'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EpisodesPage(
                                  apiProvider: apiProvider,
                                  podcastId: currentEntry.podcastId,
                                  podcastName: currentEntry.podcastName)),
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
