import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:music_player/api/api.dart';
import 'package:music_player/models/broadcast.dart';
import 'package:music_player/models/schedule.dart';

class SchedulePage extends StatelessWidget {
  final int broadcastId;
  final String broadcastName;

  const SchedulePage({super.key, required this.broadcastId, required this.broadcastName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Podcast'),
      ),
      body: FutureBuilder<List<Schedule>>(
          future: API.getSchedules(broadcastId),
          builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator()
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Schedule currentEntry = snapshot.data![index];

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
