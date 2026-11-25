import 'package:audio_service/audio_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/utils/audio_handler.dart';
import 'package:rockserwis_podcaster/utils/media_library.dart';

part 'audio_service.g.dart';

@Riverpod(keepAlive: true)
Future<MyAudioHandler> audioService(Ref ref) async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.imrahil.rockserwis.podcaster',
      androidNotificationChannelName: 'Rockserwis.fm Podcast Player',
      // Keep the media playback foreground service running while paused, so
      // playback can be resumed from the background on Android 17+ (see
      // MyAudioHandler.idleTimeout). audio_service requires the notification
      // to be dismissible in that mode.
      androidNotificationOngoing: false,
      androidStopForegroundOnPause: false,
      // Rewind / fast-forward buttons in the notification and in Android Auto
      // jump as far as the in-app buttons do.
      rewindInterval: Duration(seconds: 30),
      fastForwardInterval: Duration(seconds: 30),
      androidBrowsableRootExtras: MediaLibrary.rootExtras,
    ),
  );
}
