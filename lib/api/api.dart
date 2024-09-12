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

  Future<List<Podcast>> getPodcasts() async {
    final response = await http.get(Uri.parse(broadCastUrl));

    if (response.statusCode == 200) {
      List<Podcast> broadcastList;
      broadcastList = (json.decode(response.body) as List)
          .map((i) => Podcast.fromJson(i))
          .toList();

      return broadcastList;
    } else {
      throw Exception('Failed to load broadcasts...');
    }
  }

  Future<List<Episode>> getEpisodes(int broadcastId) async {
    String url = '$scheduleUrl/$broadcastId.json';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Episode> scheduleList;
      scheduleList = (json.decode(response.body) as List)
          .map((i) => Episode.fromJson(i))
          .toList();

      return scheduleList;
    } else {
      throw Exception('Failed to load schedules...');
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
}
