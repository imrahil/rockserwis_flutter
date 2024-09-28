import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:logger/logger.dart';
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

  var logger = Logger();

  @override
  void initState() {
    super.initState();
    _playerManager = PlayerManager();
    _currentEpisode = widget.currentEpisode;

    _setAudioSource();
  }

  @override
  void dispose() {
    _playerManager.dispose();
    super.dispose();
  }

  void _setAudioSource() async {
    final apiProvider = Provider.of<API>(context, listen: false);

    AudioSource source = AudioSource.uri(
      Uri.parse(apiProvider.getEpisodeUrl(_currentEpisode.episodeId)),
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

    final apiProvider = Provider.of<API>(context, listen: false);

    Episode? previousEpisode =
        apiProvider.getPreviousEpisode(_currentEpisode.episodeId);

    if (previousEpisode != null) {
      setState(() {
        _currentEpisode = previousEpisode;
      });

      _setAudioSource();
    }
  }

  void _skipToNext() async {
    await _playerManager.stop();

    final apiProvider = Provider.of<API>(context, listen: false);

    Episode? nextEpisode =
        apiProvider.getNextEpisode(_currentEpisode.episodeId);

    if (nextEpisode != null) {
      setState(() {
        _currentEpisode = nextEpisode;
      });

      _setAudioSource();
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<API>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentEpisode.getEpisodeTitle()),
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
              child: FutureBuilder<bool>(
                future: apiProvider.isFavoriteEpisode(_currentEpisode),
                builder: (BuildContext context, snapshot) {
                  bool isFavorite = false;

                  if (snapshot.hasData) {
                    isFavorite = snapshot.data ?? false;
                  }

                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                    onPressed: () async {
                      await apiProvider.toggleFavoriteEpisode(_currentEpisode);
                      setState(() {}); // Rebuild to update icon
                    },
                  );
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
