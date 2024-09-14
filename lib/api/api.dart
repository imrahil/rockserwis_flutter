import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:rockserwis_podcaster/models/episode.dart';

import '../models/podcast.dart';

class API {
  static const mainUrl = 'https://rockserwis.fm';
  static const broadCastUrl = '$mainUrl/broadcasts.json';
  static const scheduleUrl = '$mainUrl/audycje';
  static const loginCsrfUrl = '$mainUrl/login?get=csrf';
  static const loginPostUrl = '$mainUrl/login';

  var logger = Logger();

  String masterCookie = "";
  String sessionCookie = "";

  List<Episode> selectedPodcastEpisodes = [];

  final Map<String, String> _jsonCache = {};

  Future<List<Podcast>> getPodcasts() async {
    return await _fetchAndCacheJson(broadCastUrl, (jsonData) {
      return (json.decode(jsonData) as List)
          .map((i) => Podcast.fromJson(i))
          .toList();
    });
  }

  Future<List<Episode>> getEpisodes(Podcast currentPodcast) async {
    String url = '$scheduleUrl/${currentPodcast.podcastId}.json';

    return await _fetchAndCacheJson(url, (jsonData) {
      selectedPodcastEpisodes = (json.decode(jsonData) as List)
          .map((i) => Episode.fromJson(i))
          .toList();

      return selectedPodcastEpisodes;
    });
  }

  Future<dynamic> _fetchAndCacheJson(
      String url, Function(String) parser) async {
    // Check if data is in the cache
    if (_jsonCache.containsKey(url)) {
      logger.d('Loading from cache: $url');
      return parser(_jsonCache[url]!);
    }

    // If not in cache, fetch from network
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      logger.d('Loading from network: $url');
      final jsonData = response.body;

      // Cache the JSON data
      _jsonCache[url] = jsonData;

      return parser(jsonData);
    } else {
      throw Exception('Failed to load data from: $url');
    }
  }

  Future<bool> login(String email, String password) async {
    final loginCsrf = await http.get(Uri.parse(loginCsrfUrl));

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

      final loginCall = await http.post(Uri.parse(loginPostUrl),
          body: form, headers: {'Cookie': masterCookie});

      sessionCookie = parseCookie(loginCall);
      logger.d('sessionCookie: $sessionCookie');

      return loginCall.statusCode == 200;
    } else {
      return false;
    }
  }

  String getEpisodeUrl(int episodeId) => '$mainUrl/podcast/$episodeId';

  String getImagePath(String? imageUrl) => '$mainUrl/$imageUrl';

  Map<String, String> getHeaders() => {
        'Cookie': [masterCookie, sessionCookie].join(";")
      };

  String parseCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];

    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');

      return rawCookie.substring(0, index);
    }

    return "";
  }

  Episode? getPreviousEpisode(int currentEpisodeId) {
    final currentIndex = selectedPodcastEpisodes
        .indexWhere((episode) => episode.episodeId == currentEpisodeId);

    if (currentIndex > 0 && currentIndex < selectedPodcastEpisodes.length) {
      return selectedPodcastEpisodes[currentIndex - 1];
    } else {
      return null;
    }
  }

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
}
