import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/screens/player_manager.dart';

class Player extends StatefulWidget {
  final Episode currentEpisode;

  const Player({super.key, required this.currentEpisode});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late final PlayerManager _playerManager;
  late Episode _currentEpisode;

  @override
  void initState() {
    super.initState();
    _playerManager = PlayerManager();
    _currentEpisode = widget.currentEpisode;
  }

  @override
  void dispose() {
    _playerManager.dispose();
    super.dispose();
  }

  void _skipToPrevious() {
    _playerManager.pause();

    final apiProvider = Provider.of<API>(context, listen: false);

    Episode? previousEpisode =
        apiProvider.getPreviousEpisode(_currentEpisode.episodeId);

    if (previousEpisode != null) {
      setState(() {
        _currentEpisode = previousEpisode;
      });
    }
  }

  void _skipToNext() {
    _playerManager.pause();

    final apiProvider = Provider.of<API>(context, listen: false);

    Episode? nextEpisode =
        apiProvider.getNextEpisode(_currentEpisode.episodeId);

    if (nextEpisode != null) {
      setState(() {
        _currentEpisode = nextEpisode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<API>(context);

    AudioSource source = AudioSource.uri(
      Uri.parse(apiProvider.getEpisodeUrl(_currentEpisode.episodeId)),
      headers: apiProvider.getHeaders(),
    );

    _playerManager.setAudioSource(source);
    _playerManager.play();

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentEpisode.getEpisodeTitle()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: [
            const Spacer(),
            _currentEpisode.imgPath != null
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
                    iconSize: 40.0,
                    onPressed: _skipToPrevious),
                IconButton(
                  icon: const Icon(Icons.replay_30),
                  iconSize: 42.0,
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
                  iconSize: 42.0,
                  onPressed: _playerManager.fastForward,
                ),
                IconButton(
                    icon: const Icon(Icons.skip_next),
                    iconSize: 40.0,
                    onPressed: _skipToNext),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
