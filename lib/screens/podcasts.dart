import 'package:flutter/material.dart';
import 'package:music_player/api/api.dart';
import 'package:music_player/models/podcast.dart';
import 'package:music_player/screens/episodes.dart';

class PodcastsPage extends StatelessWidget {
  final API apiProvider;

  const PodcastsPage({super.key, required this.apiProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Podcasts!'),
      ),
      body: FutureBuilder<List<Podcast>>(
          future: apiProvider.getPodcasts(),
          builder: (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator()
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Podcast currentEntry = snapshot.data![index];

                  return ListTile(
                    title: Text(currentEntry.podcastName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EpisodesPage(apiProvider: apiProvider, podcastId: currentEntry.podcastId, podcastName: currentEntry.podcastName)),
                      );
                    },
                  );
                },
              );
            }
          }),
    );
  }
}
