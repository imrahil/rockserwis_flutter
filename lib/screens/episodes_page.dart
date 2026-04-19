import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rockserwis_podcaster/components/episodes_list.dart';
import 'package:rockserwis_podcaster/components/error_prompt.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/providers/episode_repository.dart';
import 'package:rockserwis_podcaster/providers/podcast_repository.dart';
import 'package:rockserwis_podcaster/providers/sort_order.dart';
import 'package:rockserwis_podcaster/utils/logger.dart';

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
            tooltip: 'Podcast info',
            onPressed: () => _showPodcastInfoDialog(context),
          ),
          IconButton(
            icon: Icon(
              ref.watch(sortOrderProvider) == SortOrderType.ascending
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
            ),
            tooltip: 'Toggle sort order',
            onPressed: () {
              ref.read(sortOrderProvider.notifier).change();
            },
          ),
          IconButton(
            icon: Icon(
              _isFavorited ? Icons.bookmark_remove : Icons.bookmark_add,
            ),
            tooltip: _isFavorited
                ? 'Remove from favorites'
                : 'Add to favorites',
            onPressed: () async {
              await ref
                  .read(allPodcastsProvider.notifier)
                  .toggleFavoritePodcast(_currentPodcast);
              setState(() {
                _isFavorited = !_isFavorited;
              }); // Rebuild to update icon
            },
          ),
        ],
      ),
      body: episodesAsync.when(
        skipLoadingOnReload: true,
        data: (episodes) => EpisodesList(
          episodes: episodes,
          currentPodcast: _currentPodcast,
          onRefresh: () => ref.refresh(
            episodeListProvider(_currentPodcast.podcastId).future,
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) {
          logger.e('Error loading episodes', error: e, stackTrace: st);
          return Center(
            child: ErrorPrompt(
              message: 'Could not load episodes.\nCheck your connection.',
              onRetry: () => ref.invalidate(
                episodeListProvider(_currentPodcast.podcastId),
              ),
            ),
          );
        },
      ),
    );
  }
}
