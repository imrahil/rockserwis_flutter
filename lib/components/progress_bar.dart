import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rockserwis_podcaster/providers/player_repository.dart';

class AudioProgressBar extends ConsumerWidget {
  const AudioProgressBar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerRepository = ref.watch(playerRepositoryProvider);

    return ProgressBar(
      progress: playerRepository.progress,
      buffered: playerRepository.buffered,
      total: playerRepository.total,
      onSeek: ref.read(playerRepositoryProvider.notifier).seek,
    );
  }
}
