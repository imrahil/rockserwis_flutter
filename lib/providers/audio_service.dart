import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/utils/audio_handler.dart';

part 'audio_service.g.dart';

@Riverpod(keepAlive: true)
Future<MyAudioHandler> audioService(Ref ref) async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.imrahil.rockserwis.podcaster',
      androidNotificationChannelName: 'Rockserwis.fm Podcast Player',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );
}
