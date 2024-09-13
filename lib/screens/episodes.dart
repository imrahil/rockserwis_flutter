import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/screens/player.dart';

class EpisodesPage extends StatelessWidget {
  final API apiProvider;
  final int podcastId;
  final String podcastName;

  const EpisodesPage(
      {super.key,
      required this.apiProvider,
      required this.podcastId,
      required this.podcastName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Episodes'),
      ),
      body: FutureBuilder<List<Episode>>(
          future: apiProvider.getEpisodes(podcastId),
          builder:
              (BuildContext context, AsyncSnapshot<List<Episode>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Episode currentEntry = snapshot.data![index];

                  String episodeTitle =
                      "${currentEntry.name} - ${DateFormat("yyyy-MM-dd").format(currentEntry.date)}";

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: currentEntry.imgPath != null
                          ? Image.network(
                              apiProvider.getImagePath(currentEntry.imgPath))
                          : const Icon(Icons.podcasts),
                      title: Text(
                        episodeTitle,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Podcast duration: ${currentEntry.getReadableDuration()}'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        if (currentEntry.hasPodcast) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Player(
                                    apiProvider: apiProvider,
                                    episodeId: currentEntry.episodeId,
                                    episodeTitle: episodeTitle,
                                    episodeImage: currentEntry.imgPath ?? "")),
                          );
                        }
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
