import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:logger/logger.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/api/episode_db_repository.dart';
import 'package:rockserwis_podcaster/api/episode_repository.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/utils/player_manager.dart';

class Player extends ConsumerStatefulWidget {
  final Episode currentEpisode;

  const Player({super.key, required this.currentEpisode});

  @override
  ConsumerState<Player> createState() => _PlayerState();
}

class _PlayerState extends ConsumerState<Player> {
  late final PlayerManager _playerManager;
  late Episode _currentEpisode;
  late bool _isFavorited;

  final Connectivity _connectivity = Connectivity();
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  var logger = Logger();

  @override
  void initState() {
    super.initState();
    _playerManager = PlayerManager();
    _currentEpisode = widget.currentEpisode;
    _isFavorited = widget.currentEpisode.isFavorited;

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      logger.d('ConnectivityResult: $result');

      setState(() {
        _connectionStatus = result;
      });

      if (!result.contains(ConnectivityResult.none)) {
        _setAudioSource();
      } else {
        _playerManager.stop();
      }
    });
  }

  @override
  void dispose() {
    _playerManager.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _setAudioSource() async {
    final apiProvider = ref.read(apiRepositoryProvider);
    final episodeProvider = ref.read(episodeRepositoryProvider);

    AudioSource source = AudioSource.uri(
      Uri.parse(episodeProvider.getEpisodeUrl(_currentEpisode.episodeId)),
      headers: apiProvider.getHeaders(),
      tag: MediaItem(
        // Specify a unique ID for each media item
        id: _currentEpisode.episodeId.toString(),
        // Metadata to display in the notification
        album: DateFormat("yyyy-MM-dd").format(_currentEpisode.date),
        title: _currentEpisode.name,
        artUri: _currentEpisode.imgPath != null
            ? Uri.parse(apiProvider.getImagePath(_currentEpisode.imgPath))
            : null,
      ),
    );

    await _playerManager.setAudioSource(source);
    _playerManager.play();
  }

  void _skipToPrevious() async {
    await _playerManager.stop();

    // FIXME
    // Episode? previousEpisode = ref
    //     .read(episodeRepositoryProvider)
    //     .getPreviousEpisode(_currentEpisode.episodeId!);

    // if (previousEpisode != null) {
    //   setState(() {
    //     _currentEpisode = previousEpisode;
    //   });

    //   _setAudioSource();
    // }
  }

  void _skipToNext() async {
    await _playerManager.stop();

    // FIXME
    // Episode? nextEpisode = ref
    //     .read(episodeRepositoryProvider)
    //     .getNextEpisode(_currentEpisode.episodeId);

    // if (nextEpisode != null) {
    //   setState(() {
    //     _currentEpisode = nextEpisode;
    //   });

    //   _setAudioSource();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = ref.watch(apiRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentEpisode.getEpisodeTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: [
            const Spacer(),
            _currentEpisode.imgPath != null && _currentEpisode.imgPath != ""
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
            ValueListenableBuilder<ProgressBarState>(
              valueListenable: _playerManager.progressNotifier,
              builder: (_, value, __) {
                return ProgressBar(
                    progress: value.current,
                    buffered: value.buffered,
                    total: value.total,
                    onSeek: _playerManager.seek);
              },
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
                  onPressed: _playerManager.rewind,
                ),
                StreamBuilder<PlayerState>(
                  stream: _playerManager.getAudioPlayer().playerStateStream,
                  builder: (context, snapshot) {
                    final playerState = snapshot.data;
                    final processingState = playerState?.processingState;
                    final playing = playerState?.playing;

                    if (processingState == ProcessingState.loading ||
                        processingState == ProcessingState.buffering) {
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        width: 64.0,
                        height: 64.0,
                        child: const CircularProgressIndicator(),
                      );
                    } else if (_connectionStatus
                        .contains(ConnectivityResult.none)) {
                      return IconButton(
                        icon: const Icon(Icons.wifi_off),
                        iconSize: 64.0,
                        onPressed: () {},
                      );
                    } else if (playing != true) {
                      return IconButton(
                        icon: const Icon(Icons.play_arrow),
                        iconSize: 64.0,
                        onPressed: _playerManager.play,
                      );
                    } else if (processingState != ProcessingState.completed) {
                      return IconButton(
                        icon: const Icon(Icons.pause),
                        iconSize: 64.0,
                        onPressed: _playerManager.pause,
                      );
                    } else {
                      return IconButton(
                        icon: const Icon(Icons.replay),
                        iconSize: 64.0,
                        onPressed: () => _playerManager.seek(Duration.zero),
                      );
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.forward_30),
                  iconSize: 36.0,
                  onPressed: _playerManager.fastForward,
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
