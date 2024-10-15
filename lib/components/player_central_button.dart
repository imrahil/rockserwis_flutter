import 'package:audio_service/audio_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/providers/player_repository.dart';

class CentralButton extends ConsumerWidget {
  final List<ConnectivityResult> connectionStatus;

  const CentralButton({
    super.key,
    required this.connectionStatus,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerRepository = ref.watch(playerRepositoryProvider);

    final processingState = playerRepository.processingState;
    final playing = playerRepository.playing;

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
