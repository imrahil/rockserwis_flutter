class Const {
  static const String mainUrl = 'https://rockserwis.fm';
  static const String broadCastUrl = '$mainUrl/broadcasts.json';
  static const String scheduleUrl = '$mainUrl/audycje';
  static const String loginCsrfUrl = '$mainUrl/login?get=csrf';
  static const String loginPostUrl = '$mainUrl/login';

  static const String appThemeModeKey = 'app_theme_mode';
  static const String lastUpdatedKey = 'last_updated';

  static const String rememberMeKey = 'rememberMe';
  static const String masterCookieKey = 'masterCookie';
  static const String sessionCookieKey = 'sessionCookie';

  static const String favoritePodcastsKey = 'favoritePodcasts';
  static const String favoriteEpisodesKey = 'favoriteEpisodes';

  static const String downloadsEnabledKey = 'downloads_enabled';
  static const String downloadsWifiOnlyKey = 'downloads_wifi_only';
  static const String autoDownloadFavoritesKey = 'auto_download_favorites';
  static const String maxStorageMbKey = 'max_storage_mb';
  static const String autoDeleteAfterPlayedKey = 'auto_delete_after_played';
}
