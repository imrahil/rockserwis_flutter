import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/screens/player_manager.dart';

class Player extends StatelessWidget {
  final Episode currentEpisode;

  const Player({super.key, required this.currentEpisode});

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<API>(context);

    final playerManager = PlayerManager(
      apiProvider: apiProvider,
      episodeId: currentEpisode.episodeId,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(currentEpisode.getEpisodeTitle()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: [
            const Spacer(),
            currentEpisode.imgPath != null
                ? Image.network(
                    apiProvider.getImagePath(currentEpisode.imgPath))
                : const Spacer(),
            const Spacer(),
            ValueListenableBuilder<ProgressBarState>(
              valueListenable: playerManager.progressNotifier,
              builder: (_, value, __) {
                return ProgressBar(
                    progress: value.current,
                    buffered: value.buffered,
                    total: value.total,
                    onSeek: playerManager.seek);
              },
            ),
            StreamBuilder<PlayerState>(
              stream: playerManager.getAudioPlayer().playerStateStream,
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
                    onPressed: playerManager.play,
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    iconSize: 64.0,
                    onPressed: playerManager.pause,
                  );
                } else {
                  return IconButton(
                    icon: const Icon(Icons.replay),
                    iconSize: 64.0,
                    onPressed: () => playerManager.seek(Duration.zero),
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
