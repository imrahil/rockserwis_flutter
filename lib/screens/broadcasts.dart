import 'package:flutter/material.dart';
import 'package:music_player/api/api.dart';
import 'package:music_player/models/broadcast.dart';
import 'package:music_player/screens/schedules.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Podcasts'),
      ),
      body: FutureBuilder<List<Broadcast>>(
          future: API.getBroadcasts(),
          builder: (BuildContext context, AsyncSnapshot<List<Broadcast>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator()
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Broadcast currentEntry = snapshot.data![index];

                  return ListTile(
                    title: Text(currentEntry.broadcastName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SchedulePage(broadcastId: currentEntry.broadcastId, broadcastName: currentEntry.broadcastName)),
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
