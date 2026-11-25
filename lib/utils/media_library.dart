import 'package:audio_service/audio_service.dart';
import 'package:intl/intl.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/utils/logger.dart';

/// The media browse tree shown by Android Auto (and by other media browsers,
/// such as the system's media resumption controls).
///
/// ```text
/// root (AudioService.browsableRootId)
///   ├─ recent_episodes     → playable episodes, most recently played first
///   ├─ favorite_episodes   → playable episodes
///   ├─ favorite_podcasts   → podcast:<podcastId> folders
///   └─ all_podcasts        → podcast:<podcastId> folders
/// podcast:<podcastId>      → playable episodes, newest first
/// recent (AudioService.recentRootId) → the last played episode
/// ```
///
/// Playable items have the ID `episode:<episodeId>`.
///
/// The data access is passed in as functions, so the tree can be built (and
/// tested) without Riverpod or ObjectBox.
class MediaLibrary {
  MediaLibrary({
    required this.loadPodcasts,
    required this.loadEpisodes,
    required this.imageUrl,
    required this.isLoggedIn,
    required this.playEpisode,
  });

  final Future<List<Podcast>> Function() loadPodcasts;
  final Future<List<Episode>> Function() loadEpisodes;

  /// Turns a relative image path from the API into a full URL.
  final String Function(String path) imageUrl;
  final bool Function() isLoggedIn;
  final Future<void> Function(Episode episode) playEpisode;

  static const recentEpisodesId = 'recent_episodes';
  static const favoriteEpisodesId = 'favorite_episodes';
  static const favoritePodcastsId = 'favorite_podcasts';
  static const allPodcastsId = 'all_podcasts';
  static const signInId = 'sign_in';
  static const podcastPrefix = 'podcast:';
  static const episodePrefix = 'episode:';

  /// How many episodes the "Recent" tab shows, and how far back it looks.
  /// Same as the History screen.
  static const recentLimit = 10;
  static const recentMaxAge = Duration(days: 10);

  /// Episodes get this `updatedAt` when synced, so it means "never played".
  static final neverPlayedDate = DateTime.utc(2000, 1, 1);

  /// Extras understood by Android Auto, see androidx.media.utils.MediaConstants.
  static const _completionStatusKey = 'android.media.extra.PLAYBACK_STATUS';
  static const _completionPercentageKey =
      'androidx.media.MediaItem.Extras.COMPLETION_PERCENTAGE';
  static const _notPlayed = 0;
  static const _partiallyPlayed = 1;
  static const _fullyPlayed = 2;

  /// Show both folders and episodes as lists rather than grids. Passed to
  /// AudioServiceConfig.androidBrowsableRootExtras.
  static const rootExtras = <String, dynamic>{
    'android.media.browse.CONTENT_STYLE_SUPPORTED': true,
    'android.media.browse.CONTENT_STYLE_BROWSABLE_HINT': 1,
    'android.media.browse.CONTENT_STYLE_PLAYABLE_HINT': 1,
  };

  /// An episode counts as played once this share of it has been heard.
  static const _playedThreshold = 0.95;

  Future<List<MediaItem>> getChildren(String parentMediaId) async {
    try {
      return await _getChildren(parentMediaId);
    } catch (e, st) {
      logger.e(
        'Could not load media children of $parentMediaId',
        error: e,
        stackTrace: st,
      );
      return const [];
    }
  }

  Future<List<MediaItem>> _getChildren(String parentMediaId) async {
    if (parentMediaId == AudioService.browsableRootId) {
      return isLoggedIn() ? _rootItems : [_signInItem];
    }

    if (parentMediaId == AudioService.recentRootId) {
      final last = lastPlayed(await loadEpisodes());
      return last == null ? const [] : [episodeToMediaItem(last)];
    }

    switch (parentMediaId) {
      case recentEpisodesId:
        return _episodeItems(recentlyPlayed(await loadEpisodes()));
      case favoriteEpisodesId:
        final favorites =
            (await loadEpisodes())
                .where((episode) => episode.isFavorited)
                .toList()
              ..sort((a, b) => a.name.compareTo(b.name));
        return _episodeItems(favorites);
      case favoritePodcastsId:
        return _podcastItems(
          (podcast) => podcast.isFavorited,
          await loadEpisodes(),
        );
      case allPodcastsId:
        return _podcastItems((_) => true, await loadEpisodes());
    }

    final podcastId = _parseId(parentMediaId, podcastPrefix);
    if (podcastId != null) {
      final episodes =
          (await loadEpisodes())
              .where((episode) => episode.podcastId == podcastId)
              .toList()
            ..sort((a, b) => b.date.compareTo(a.date));
      return _episodeItems(episodes);
    }

    return const [];
  }

  Future<MediaItem?> getMediaItem(String mediaId) async {
    final episode = await _findEpisode(mediaId);
    return episode == null ? null : episodeToMediaItem(episode);
  }

  /// Plays the episode with the given media ID. Returns false if there is no
  /// such episode.
  Future<bool> playFromMediaId(String mediaId) async {
    final episode = await _findEpisode(mediaId);
    if (episode == null) {
      logger.w('No episode for media ID $mediaId');
      return false;
    }
    await playEpisode(episode);
    return true;
  }

  /// Handles voice requests such as "play `<podcast>` on Rockcaster".
  ///
  /// An empty query (just "play Rockcaster") resumes the last played episode.
  /// Otherwise the newest episode of the first matching podcast is played,
  /// or else the newest episode with a matching name.
  Future<bool> playFromSearch(String query) async {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return playLastPlayed();

    final episodes = await loadEpisodes();
    Episode? newest(Iterable<Episode> candidates) => candidates.isEmpty
        ? null
        : candidates.reduce((a, b) => a.date.isAfter(b.date) ? a : b);

    final podcasts =
        (await loadPodcasts())
            .where((p) => p.podcastName.toLowerCase().contains(normalized))
            .toList()
          ..sort((a, b) => a.podcastName.compareTo(b.podcastName));

    for (final podcast in podcasts) {
      final episode = newest(
        episodes.where((episode) => episode.podcastId == podcast.podcastId),
      );
      if (episode != null) {
        await playEpisode(episode);
        return true;
      }
    }

    final episode = newest(
      episodes.where(
        (episode) => episode.name.toLowerCase().contains(normalized),
      ),
    );
    if (episode != null) {
      await playEpisode(episode);
      return true;
    }

    logger.d('No episode matches the voice query "$query"');
    return false;
  }

  /// Resumes the most recently played episode. Returns false if nothing has
  /// been played yet.
  Future<bool> playLastPlayed() async {
    final episode = lastPlayed(await loadEpisodes());
    if (episode == null) return false;
    await playEpisode(episode);
    return true;
  }

  MediaItem episodeToMediaItem(Episode episode) =>
      episodeMediaItem(episode, imageUrl: imageUrl);

  /// The [MediaItem] for an episode, used both in the browse tree and as the
  /// item that is currently playing.
  static MediaItem episodeMediaItem(
    Episode episode, {
    required String Function(String path) imageUrl,
  }) {
    final date = DateFormat('yyyy-MM-dd').format(episode.date);
    final seconds = episode.episodeDuration.toInt();
    final duration = seconds > 0 ? Duration(seconds: seconds) : null;

    return MediaItem(
      id: '$episodePrefix${episode.episodeId}',
      title: episode.name,
      album: date,
      displaySubtitle: duration == null
          ? date
          : '$date · ${episode.getReadableDuration}',
      duration: duration,
      artUri: episode.imgPath.isNotEmpty
          ? Uri.parse(imageUrl(episode.imgPath))
          : null,
      playable: true,
      extras: _completionExtras(episode),
    );
  }

  /// Episodes played within [recentMaxAge], most recent first, like the
  /// History screen.
  static List<Episode> recentlyPlayed(List<Episode> episodes, {DateTime? now}) {
    final since = (now ?? DateTime.now()).subtract(recentMaxAge);
    final recent =
        episodes
            .where(
              (episode) =>
                  episode.updatedAt != null &&
                  episode.updatedAt!.isAfter(since),
            )
            .toList()
          ..sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
    return recent.take(recentLimit).toList();
  }

  /// The episode played most recently, however long ago, or null.
  static Episode? lastPlayed(List<Episode> episodes) {
    Episode? last;
    for (final episode in episodes) {
      final updatedAt = episode.updatedAt;
      if (updatedAt == null || !updatedAt.isAfter(neverPlayedDate)) continue;
      if (last == null || updatedAt.isAfter(last.updatedAt!)) last = episode;
    }
    return last;
  }

  static const _rootItems = [
    MediaItem(id: recentEpisodesId, title: 'Recent', playable: false),
    MediaItem(id: favoriteEpisodesId, title: 'Favourites', playable: false),
    MediaItem(
      id: favoritePodcastsId,
      title: 'Favourite podcasts',
      playable: false,
    ),
    MediaItem(id: allPodcastsId, title: 'All podcasts', playable: false),
  ];

  static const _signInItem = MediaItem(
    id: signInId,
    title: 'Sign in on your phone',
    displaySubtitle: 'Open Rockcaster on your phone and sign in',
    playable: false,
  );

  List<MediaItem> _episodeItems(List<Episode> episodes) =>
      episodes.map(episodeToMediaItem).toList();

  /// Podcasts matching [test] that have at least one synced episode, as
  /// browsable folders sorted by name.
  Future<List<MediaItem>> _podcastItems(
    bool Function(Podcast podcast) test,
    List<Episode> episodes,
  ) async {
    final withEpisodes = episodes.map((episode) => episode.podcastId).toSet();

    final podcasts =
        (await loadPodcasts())
            .where(
              (podcast) =>
                  test(podcast) && withEpisodes.contains(podcast.podcastId),
            )
            .toList()
          ..sort((a, b) => a.podcastName.compareTo(b.podcastName));

    return [
      for (final podcast in podcasts)
        MediaItem(
          id: '$podcastPrefix${podcast.podcastId}',
          title: podcast.podcastName,
          artUri: podcast.image.isNotEmpty
              ? Uri.parse(imageUrl(podcast.image))
              : null,
          playable: false,
        ),
    ];
  }

  Future<Episode?> _findEpisode(String mediaId) async {
    // Older builds used the bare episode ID as the media ID.
    final episodeId = _parseId(mediaId, episodePrefix) ?? int.tryParse(mediaId);
    if (episodeId == null) return null;

    for (final episode in await loadEpisodes()) {
      if (episode.episodeId == episodeId) return episode;
    }
    return null;
  }

  static int? _parseId(String mediaId, String prefix) =>
      mediaId.startsWith(prefix)
      ? int.tryParse(mediaId.substring(prefix.length))
      : null;

  static Map<String, dynamic> _completionExtras(Episode episode) {
    if (episode.progress <= 0 || episode.total <= 0) {
      return const {_completionStatusKey: _notPlayed};
    }

    final share = (episode.progress / episode.total).clamp(0.0, 1.0);
    if (share >= _playedThreshold) {
      return const {_completionStatusKey: _fullyPlayed};
    }

    return {
      _completionStatusKey: _partiallyPlayed,
      _completionPercentageKey: share,
    };
  }
}
