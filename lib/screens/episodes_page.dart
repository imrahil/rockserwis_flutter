import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/components/episodes_list.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';

class EpisodesPage extends StatefulWidget {
  final Podcast currentPodcast;

  const EpisodesPage({super.key, required this.currentPodcast});

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  late Podcast _currentPodcast;

  @override
  void initState() {
    super.initState();

    _currentPodcast = widget.currentPodcast;
  }

  Future<List<Episode>> fetchEpisodes(context) {
    final apiProvider = Provider.of<API>(context);

    return apiProvider.getEpisodes(_currentPodcast);
  }

  void _showPodcastInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Podcast Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${_currentPodcast.podcastName}'),
              const SizedBox(height: 16.0),
              const Text('Authors:'),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _currentPodcast.authors.map((author) {
                    return Text('• ${author.name}');
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Schedule:'),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _currentPodcast.schedules.map((schedule) {
                    final startTime = DateFormat('HH:mm')
                        .format(DateFormat('HH:mm:ss').parse(schedule.start));
                    final endTime = DateFormat('HH:mm')
                        .format(DateFormat('HH:mm:ss').parse(schedule.end));
                    final dayName = DateFormat('EEEE').format(DateTime.now()
                        .subtract(Duration(
                            days: DateTime.now().weekday - schedule.weekday)));

                    return Text('• $dayName, $startTime - $endTime');
                  }).toList(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<API>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentPodcast.podcastName),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showPodcastInfoDialog(context),
          ),
          FutureBuilder<bool>(
            future: apiProvider.isFavoritePodcast(_currentPodcast),
            builder: (BuildContext context, snapshot) {
              bool isFavorite = false;

              if (snapshot.hasData) {
                isFavorite = snapshot.data ?? false;
              }

              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.bookmark_remove : Icons.bookmark_add,
                ),
                onPressed: () async {
                  await apiProvider.toggleFavoritePodcast(_currentPodcast);
                  setState(() {}); // Rebuild to update icon
                },
              );
            },
          ),
        ],
      ),
      body: EpisodesList(
        episodesFuture: fetchEpisodes(context),
      ),
    );
  }
}
