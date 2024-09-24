import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/podcast.dart';

class API {
  static const mainUrl = 'https://rockserwis.fm';
  static const broadCastUrl = '$mainUrl/broadcasts.json';
  static const scheduleUrl = '$mainUrl/audycje';
  static const loginCsrfUrl = '$mainUrl/login?get=csrf';
  static const loginPostUrl = '$mainUrl/login';

  static const String favoriteEpisodesKey = 'favoriteEpisodes';
  static const String favoritePodcastsKey = 'favoritePodcasts';

  var logger = Logger();

  String masterCookie = "";
  String sessionCookie = "";
  http.Client client;

  List<Episode> selectedPodcastEpisodes = [];

  final Map<String, String> _jsonCache = {};
  final Map<String, DateTime> _cacheLastUpdated = {};

  API({required this.client, this.masterCookie = "", this.sessionCookie = ""});

  /// Fetches and caches JSON data for all podcasts.
  ///
  /// @param forceRefresh Whether to force a refresh from the network, even if data is in the cache.
  /// @return A list of all podcasts.
  Future<List<Podcast>> getPodcasts({bool forceRefresh = false}) async {
    return await _fetchAndCacheJson(broadCastUrl, (jsonData) {
      return (json.decode(jsonData) as List)
          .map((i) => Podcast.fromJson(i))
          .toList();
    }, forceRefresh: forceRefresh);
  }

  /// Fetches and caches JSON data for episodes of a specific podcast.
  ///
  /// @param currentPodcast The podcast to fetch episodes for.
  /// @param forceRefresh Whether to force a refresh from the network, even if data is in the cache.
  /// @return A list of episodes for the given podcast.
  Future<List<Episode>> getEpisodes(Podcast currentPodcast,
      {bool forceRefresh = false}) async {
    String url = '$scheduleUrl/${currentPodcast.podcastId}.json';

    return await _fetchAndCacheJson(url, (jsonData) {
      selectedPodcastEpisodes = (json.decode(jsonData) as List)
          .map((i) => Episode.fromJson(i))
          .toList();

      return selectedPodcastEpisodes;
    }, forceRefresh: forceRefresh);
  }

  /// Fetches JSON data from the given URL and caches it.
  ///
  /// @param url The URL to fetch data from.
  /// @param parser A function that parses the JSON data into the desired format.
  /// @param forceRefresh Whether to force a refresh from the network, even if data is in the cache.
  /// @return The parsed JSON data.
  Future<dynamic> _fetchAndCacheJson(String url, Function(String) parser,
      {bool forceRefresh = false}) async {
    // Check if data is in the cache and not being forced to refresh
    if (_jsonCache.containsKey(url) && !forceRefresh && _shouldUseCache(url)) {
      logger.d('Loading from cache: $url');
      return parser(_jsonCache[url]!);
    }

    // If not in cache, fetch from network
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      logger.d('Loading from network: $url');
      final jsonData = response.body;

      // Cache the JSON data and update last fetched time
      _jsonCache[url] = jsonData;
      _cacheLastUpdated[url] = DateTime.now();

      return parser(jsonData);
    } else {
      throw Exception('Failed to load data from: $url');
    }
  }

  /// Logs in to the Rockserwis.fm API.
  ///
  /// @param email The user's email address.
  /// @param password The user's password.
  /// @param rememberMe Whether to remember the user's login credentials.
  /// @return True if the login was successful, false otherwise.
  Future<bool> login(String email, String password, bool rememberMe) async {
    logger.d('Logging in... - $loginCsrfUrl');

    final loginCsrf = await client.get(Uri.parse(loginCsrfUrl));

    logger.d('status code: ${loginCsrf.statusCode}');

    if (loginCsrf.statusCode == 200) {
      masterCookie = parseCookie(loginCsrf);
      logger.d('csrfTokenCookie: $masterCookie');

      String loginToken = loginCsrf.body;
      logger.d('loginToken: $loginToken');

      var form = <String, dynamic>{};
      form['csrf-token'] = loginToken;
      form['email'] = email;
      form['password'] = password;
      form['method'] = 'login';

      final loginCall = await client.post(Uri.parse(loginPostUrl),
          body: form, headers: {'Cookie': masterCookie});

      sessionCookie = parseCookie(loginCall);
      logger.d('sessionCookie: $sessionCookie');

      if (rememberMe) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool('rememberMe', rememberMe);

        await prefs.setString('masterCookie', masterCookie);
        await prefs.setString('sessionCookie', sessionCookie);
      }

      return loginCall.statusCode == 200;
    } else {
      logger.d("Something went wrong... login failed!");

      return false;
    }
  }

  /// Logs out of the Rockserwis.fm API.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', false);
    await prefs.remove('masterCookie');
    await prefs.remove('sessionCookie');
  }

  /// Gets the URL for a specific episode.
  ///
  /// @param episodeId The ID of the episode.
  /// @return The URL for the episode.
  String getEpisodeUrl(int episodeId) => '$mainUrl/podcast/$episodeId';

  /// Gets the URL for the podcast image.
  ///
  /// @param imageUrl The URL of the podcast image.
  /// @return The URL for the podcast image.
  String getImagePath(String? imageUrl) => '$mainUrl/$imageUrl';

  // Helper function to get the headers for API requests
  Map<String, String> getHeaders() => {
        'Cookie': [masterCookie, sessionCookie].join(";")
      };

  // Helper function to parse the cookie from the response
  String parseCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];

    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');

      return rawCookie.substring(0, index);
    }

    return "";
  }

  /// Helper function to get the previous episode in the list
  Episode? getPreviousEpisode(int currentEpisodeId) {
    final currentIndex = selectedPodcastEpisodes
        .indexWhere((episode) => episode.episodeId == currentEpisodeId);

    if (currentIndex > 0 && currentIndex < selectedPodcastEpisodes.length) {
      return selectedPodcastEpisodes[currentIndex - 1];
    } else {
      return null;
    }
  }

  /// Helper function to get the next episode in the list
  Episode? getNextEpisode(int currentEpisodeId) {
    final currentIndex = selectedPodcastEpisodes
        .indexWhere((episode) => episode.episodeId == currentEpisodeId);

    if (currentIndex >= 0 &&
        currentIndex < selectedPodcastEpisodes.length - 1) {
      return selectedPodcastEpisodes[currentIndex + 1];
    } else {
      return null;
    }
  }

  /// Helper function to determine if the cache should be used
  bool _shouldUseCache(String url) {
    // Cache for 2 hour
    const cacheDuration = Duration(hours: 2);

    if (!_cacheLastUpdated.containsKey(url)) {
      return false;
    }

    final lastUpdated = _cacheLastUpdated[url]!;
    final now = DateTime.now();

    return now.difference(lastUpdated) < cacheDuration;
  }

  /// Gets the list of favorite podcasts from SharedPreferences.
  ///
  /// @return A list of favorite podcasts.
  Future<List<Podcast>> getFavoritePodcasts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoritePodcasts =
        prefs.getStringList(favoritePodcastsKey) ?? [];

    return favoritePodcasts.map((podcastString) {
      final podcastJson = jsonDecode(podcastString);
      return Podcast.fromJson(podcastJson);
    }).toList();
  }

  /// Toggles the favorite status of an podcast.
  ///
  /// @param podcast The episode to toggle the favorite status of.
  Future<void> toggleFavoritePodcast(Podcast podcast) async {
    final prefs = await SharedPreferences.getInstance();

    // Get current favorites from SharedPreferences
    List<String> favoritePodcasts =
        prefs.getStringList(favoritePodcastsKey) ?? [];

    final podcastString = jsonEncode(podcast);

    // Toggle favorite status
    if (favoritePodcasts.contains(podcastString)) {
      favoritePodcasts.remove(podcastString);
    } else {
      favoritePodcasts.add(podcastString);
    }

    // Save updated favorites back to SharedPreferences
    await prefs.setStringList(favoritePodcastsKey, favoritePodcasts);
  }

  /// Checks if a podcast is a favorite.
  ///
  /// @param podcast The podcast to check.
  /// @return True if the podcast is a favorite, false otherwise.
  Future<bool> isFavoritePodcast(Podcast podcast) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favoritePodcasts =
        prefs.getStringList(favoritePodcastsKey) ?? [];

    final podcastIdString = jsonEncode(podcast);

    return favoritePodcasts.contains(podcastIdString);
  }

  Future<List<Episode>> getFavoriteEpisodes() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteEpisodes =
        prefs.getStringList(favoriteEpisodesKey) ?? [];

    selectedPodcastEpisodes = favoriteEpisodes.map((episodeString) {
      final episodeJson = jsonDecode(episodeString);
      return Episode.fromJson(episodeJson);
    }).toList();

    return selectedPodcastEpisodes;
  }

  /// Toggles the favorite status of an episode.
  ///
  /// @param episode The episode to toggle the favorite status of.
  Future<void> toggleFavoriteEpisode(Episode episode) async {
    final prefs = await SharedPreferences.getInstance();

    // Get current favorites from SharedPreferences
    List<String> favoriteEpisodes =
        prefs.getStringList(favoriteEpisodesKey) ?? [];

    final episodeString = jsonEncode(episode);

    // Toggle favorite status
    if (favoriteEpisodes.contains(episodeString)) {
      favoriteEpisodes.remove(episodeString);
    } else {
      favoriteEpisodes.add(episodeString);
    }

    // Save updated favorites back to SharedPreferences
    await prefs.setStringList(favoriteEpisodesKey, favoriteEpisodes);
  }

  /// Checks if an episode is a favorite.
  ///
  /// @param episode The episode to check.
  /// @return True if the episode is a favorite, false otherwise.
  Future<bool> isFavoriteEpisode(Episode episode) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> favoriteEpisodes =
        prefs.getStringList(favoriteEpisodesKey) ?? [];

    final episodeIdString = jsonEncode(episode);

    return favoriteEpisodes.contains(episodeIdString);
  }
}
