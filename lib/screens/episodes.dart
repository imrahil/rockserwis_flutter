import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_player/api/api.dart';
import 'package:music_player/models/episode.dart';

class EpisodesPage extends StatelessWidget {
  final int broadcastId;
  final String broadcastName;

  const EpisodesPage({super.key, required this.broadcastId, required this.broadcastName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Episodes'),
      ),
      body: FutureBuilder<List<Episode>>(
          future: API.getEpisodes(broadcastId),
          builder: (BuildContext context, AsyncSnapshot<List<Episode>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator()
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Episode currentEntry = snapshot.data![index];

                  return ListTile(
                      title: Text("${currentEntry.name} - ${DateFormat("yyyy-MM-dd").format(currentEntry.date)}"),
                  );
                },
              );
            }
          }),
    );
  }
}
