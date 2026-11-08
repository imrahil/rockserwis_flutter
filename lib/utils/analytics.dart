import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/utils/logger.dart';

part 'analytics.g.dart';

/// App-specific wrapper around Firebase Analytics (Google Analytics 4).
///
/// Logging is fire-and-forget: calls never block the caller and never throw,
/// so analytics can't break app features, or tests, where Firebase isn't
/// initialized.
class AppAnalytics {
  AppAnalytics([this._analytics]);

  FirebaseAnalytics? _analytics;
  FirebaseAnalytics get _instance => _analytics ??= FirebaseAnalytics.instance;

  String? _lastScreen;

  /// Logs a `screen_view`. Repeated calls for the same screen are ignored.
  void logScreenView(String screenName) {
    if (screenName == _lastScreen) return;
    _lastScreen = screenName;
    _run(() => _instance.logScreenView(
          screenName: screenName,
          screenClass: screenName,
        ));
  }

  void logLogin() => _run(() => _instance.logLogin(loginMethod: 'email'));

  void logLogout() => _log('logout');

  void logEpisodePlay(Episode episode, {required bool fromDownload}) =>
      _log('episode_play', {
        ..._episodeParams(episode),
        'source': fromDownload ? 'download' : 'stream',
        'resumed': episode.progress > 0 ? 1 : 0,
      });

  void logEpisodeComplete(Episode episode) =>
      _log('episode_complete', _episodeParams(episode));

  void logFavoriteEpisode(Episode episode, {required bool favorited}) =>
      _log(favorited ? 'favorite_add' : 'favorite_remove', {
        'item_type': 'episode',
        ..._episodeParams(episode),
      });

  void logFavoritePodcast(Podcast podcast, {required bool favorited}) =>
      _log(favorited ? 'favorite_add' : 'favorite_remove', {
        'item_type': 'podcast',
        'podcast_id': podcast.podcastId,
        'podcast_name': _limit(podcast.podcastName),
      });

  void logDownloadStart(Episode episode, {required bool auto}) =>
      _log('download_start', {
        ..._episodeParams(episode),
        'trigger': auto ? 'auto' : 'manual',
      });

  void logDownloadComplete(int episodeId) =>
      _log('download_complete', {'episode_id': episodeId});

  Map<String, Object> _episodeParams(Episode episode) => {
        'episode_id': episode.episodeId,
        if (episode.podcastId != null) 'podcast_id': episode.podcastId!,
        'episode_name': _limit(episode.name),
      };

  /// GA4 drops parameter values longer than 100 characters.
  static String _limit(String value) =>
      value.length <= 100 ? value : value.substring(0, 100);

  void _log(String name, [Map<String, Object>? parameters]) =>
      _run(() => _instance.logEvent(name: name, parameters: parameters));

  void _run(Future<void> Function() call) {
    try {
      unawaited(call().catchError((Object error) {
        logger.w('Analytics call failed: $error');
      }));
    } catch (error) {
      logger.w('Analytics unavailable: $error');
    }
  }
}

@Riverpod(keepAlive: true)
AppAnalytics analytics(Ref ref) => AppAnalytics();
