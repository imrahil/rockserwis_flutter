import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/api/episode_repository.dart';
import 'package:rockserwis_podcaster/api/player_repository.dart';
import 'package:rockserwis_podcaster/models/episode.dart';

class Player extends ConsumerStatefulWidget {
  final Episode currentEpisode;
  final List<Episode> episodes;

  const Player(
      {super.key, required this.currentEpisode, required this.episodes});

  @override
  ConsumerState<Player> createState() => _PlayerState();
}

class _PlayerState extends ConsumerState<Player> {
  late Episode _currentEpisode;
  late List<Episode> _episodes;
  late bool _isFavorited;

  final Connectivity _connectivity = Connectivity();
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  var logger = Logger();

  @override
  void initState() {
    super.initState();
    _currentEpisode = widget.currentEpisode;
    _episodes = widget.episodes;
    _isFavorited = widget.currentEpisode.isFavorited;

    final playerRepository = ref.read(playerRepositoryProvider.notifier);

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) async {
      logger.d('ConnectivityResult: $result');

      setState(() {
        _connectionStatus = result;
      });

      if (!result.contains(ConnectivityResult.none)) {
        _setAudioSource();
      } else {
        await playerRepository.stop();
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _setAudioSource() async {
    final playerRepository = ref.read(playerRepositoryProvider.notifier);

    playerRepository.setAudioSource(_currentEpisode);
  }

  void _skipToPrevious() async {
    final currentIndex = _episodes.indexWhere(
        (episode) => episode.episodeId == _currentEpisode.episodeId);

    if (currentIndex > 0 && currentIndex < _episodes.length) {
      final playerRepository = ref.read(playerRepositoryProvider.notifier);
      await playerRepository.stop();

      setState(() {
        _currentEpisode = _episodes[currentIndex - 1];
      });

      _setAudioSource();
    }
  }

  void _skipToNext() async {
    final currentIndex = _episodes.indexWhere(
        (episode) => episode.episodeId == _currentEpisode.episodeId);

    if (currentIndex >= 0 && currentIndex < _episodes.length - 1) {
      final playerRepository = ref.read(playerRepositoryProvider.notifier);
      await playerRepository.stop();

      setState(() {
        _currentEpisode = _episodes[currentIndex + 1];
      });

      _setAudioSource();
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = ref.watch(apiRepositoryProvider);
    final playerRepositoryNotifier =
        ref.read(playerRepositoryProvider.notifier);
    final playerRepository = ref.watch(playerRepositoryProvider);

    final processingState = playerRepository.processingState;
    final playing = playerRepository.playing;

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentEpisode.getEpisodeTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: [
            const Spacer(),
            _currentEpisode.imgPath != ""
                ? CachedNetworkImage(
                    // Use CachedNetworkImage
                    imageUrl: apiProvider.getImagePath(_currentEpisode.imgPath),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : const Spacer(),
            const Spacer(),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  _isFavorited ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () async {
                  await ref
                      .read(favoritedEpisodesProvider.notifier)
                      .toggleFavoriteEpisode(_currentEpisode);
                  setState(() {
                    _isFavorited = !_isFavorited;
                  }); // Rebuild to update icon
                },
              ),
            ),
            ProgressBar(
              progress: playerRepository.progress,
              buffered: playerRepository.buffered,
              total: playerRepository.total,
              onSeek: playerRepositoryNotifier.seek,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous),
                  iconSize: 34.0,
                  onPressed: _skipToPrevious,
                ),
                IconButton(
                  icon: const Icon(Icons.replay_30),
                  iconSize: 36.0,
                  onPressed: playerRepositoryNotifier.rewind,
                ),
                CentralButton(
                  processingState: processingState,
                  playing: playing,
                  connectionStatus: _connectionStatus,
                ),
                IconButton(
                  icon: const Icon(Icons.forward_30),
                  iconSize: 36.0,
                  onPressed: playerRepositoryNotifier.fastForward,
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  iconSize: 34.0,
                  onPressed: _skipToNext,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CentralButton extends ConsumerWidget {
  final AudioProcessingState processingState;
  final bool playing;
  final List<ConnectivityResult> connectionStatus;

  const CentralButton({
    super.key,
    required this.processingState,
    required this.playing,
    required this.connectionStatus,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerRepositoryNotifier =
        ref.read(playerRepositoryProvider.notifier);

    if (processingState == AudioProcessingState.loading ||
        processingState == AudioProcessingState.buffering) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        width: 64.0,
        height: 64.0,
        child: const CircularProgressIndicator(),
      );
    } else if (connectionStatus.contains(ConnectivityResult.none)) {
      return IconButton(
        icon: const Icon(Icons.wifi_off),
        iconSize: 64.0,
        onPressed: () {},
      );
    } else if (playing != true) {
      return IconButton(
        icon: const Icon(Icons.play_arrow),
        iconSize: 64.0,
        onPressed: playerRepositoryNotifier.play,
      );
    } else if (processingState != AudioProcessingState.completed) {
      return IconButton(
        icon: const Icon(Icons.pause),
        iconSize: 64.0,
        onPressed: playerRepositoryNotifier.pause,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.replay),
        iconSize: 64.0,
        onPressed: () => playerRepositoryNotifier.seek(Duration.zero),
      );
    }
  }
}
