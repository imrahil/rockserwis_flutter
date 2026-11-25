import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/providers/audio_service.dart';
import 'package:rockserwis_podcaster/providers/objectbox_repository.dart';
import 'package:rockserwis_podcaster/providers/player_repository.dart';
import 'package:rockserwis_podcaster/utils/media_library.dart';

part 'media_library.g.dart';

/// Connects the [MediaLibrary] (what Android Auto browses and plays) to the
/// audio handler.
///
/// Read this in main() before runApp: when Android Auto starts the app in
/// the background there is no activity and no UI, so nothing else would
/// initialise the audio service and answer Android Auto's requests.
@Riverpod(keepAlive: true)
Future<MediaLibrary> mediaLibrary(Ref ref) async {
  final handler = await ref.watch(audioServiceProvider.future);
  final objectBox = await ref.watch(objectBoxProvider.future);
  final api = ref.watch(apiRepositoryProvider);

  final library = MediaLibrary(
    // Read the database directly rather than through allEpisodesProvider, so
    // that episodes added by a sync are always included.
    loadPodcasts: () => objectBox.podcastBox.getAllAsync(),
    loadEpisodes: () => objectBox.episodeBox.getAllAsync(),
    imageUrl: api.getImagePath,
    isLoggedIn: api.isLogged,
    // Play through PlayerRepository, like the app's own screens do, so the
    // episode's position, history entry and analytics are kept up to date.
    playEpisode: (episode) =>
        ref.read(playerRepositoryProvider.notifier).setAudioSource(episode),
  );

  handler.mediaLibrary = library;
  ref.onDispose(() => handler.mediaLibrary = null);

  return library;
}
