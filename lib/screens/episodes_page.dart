import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rockserwis_podcaster/api/episode_db_repository.dart';
import 'package:rockserwis_podcaster/api/podcast_db_repository.dart';
import 'package:rockserwis_podcaster/components/episodes_list.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';

class EpisodesPage extends ConsumerStatefulWidget {
  final Podcast currentPodcast;

  const EpisodesPage({super.key, required this.currentPodcast});

  @override
  ConsumerState<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends ConsumerState<EpisodesPage> {
  late Podcast _currentPodcast;
  late bool _isFavorited;

  @override
  void initState() {
    super.initState();

    _currentPodcast = widget.currentPodcast;
    _isFavorited = widget.currentPodcast.isFavorited;
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
    final episodesAsync =
        ref.watch(episodeListProvider(_currentPodcast.podcastId));

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentPodcast.podcastName),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showPodcastInfoDialog(context),
          ),
          IconButton(
            icon: Icon(
              _isFavorited ? Icons.bookmark_remove : Icons.bookmark_add,
            ),
            onPressed: () async {
              await ref
                  .read(favoritedPodcastsProvider.notifier)
                  .toggleFavoritePodcast(_currentPodcast);
              setState(() {
                _isFavorited = !_isFavorited;
              }); // Rebuild to update icon
            },
          ),
        ],
      ),
      body: episodesAsync.when(
        data: (episodes) => EpisodesList(
          episodes: episodes,
          currentPodcast: _currentPodcast,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(child: Text('Error loading episodes...')),
      ),
    );
  }
}
