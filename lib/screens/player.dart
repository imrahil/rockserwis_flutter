import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/screens/player_manager.dart';

class Player extends StatefulWidget {
  final API apiProvider;
  final int episodeId;
  final String episodeTitle;
  final String episodeImage;

  const Player(
      {super.key,
      required this.apiProvider,
      required this.episodeId,
      required this.episodeTitle,
      required this.episodeImage});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late final PlayerManager _playerManager;

  @override
  void initState() {
    super.initState();
    _playerManager = PlayerManager(
        apiProvider: widget.apiProvider, episodeId: widget.episodeId);
  }

  @override
  void dispose() {
    _playerManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var imagePath = API.mainUrl + widget.episodeImage;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.episodeTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: [
            const Spacer(),
            widget.episodeImage != ""
                ? Image.network(imagePath)
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
          ],
        ),
      ),
    );
  }
}
