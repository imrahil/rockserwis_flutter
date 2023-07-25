import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_player/models/episode.dart';
import 'package:music_player/models/form_data.dart';
import '../models/podcast.dart';

const mainUrl = 'https://rockserwis.fm';
const broadCastUrl = '$mainUrl/broadcasts.json';
const scheduleUrl = '$mainUrl/audycje';
const loginCsrfUrl = '$mainUrl/login?get=csrf';
const loginPostUrl = '$mainUrl/login';

class API {
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

  Future<bool> login(FormData formData) async {
    final loginCsrf = await http.get(Uri.parse(loginCsrfUrl));

    if (loginCsrf.statusCode == 200) {
      masterCookie = parseCookie(loginCsrf);
      print('csrfTokenCookie: $masterCookie');

      String loginToken = loginCsrf.body;
      print('loginToken: $loginToken');

      var form = <String, dynamic>{};
      form['csrf-token'] = loginToken;
      form['email'] = formData.email;
      form['password'] = formData.password;
      form['method'] = 'login';

      final loginCall = await http.post(
          Uri.parse(loginPostUrl),
          body: form,
          headers: {
            'Cookie': masterCookie
          }
      );

      sessionCookie = parseCookie(loginCall);
      print('sessionCookie: $sessionCookie');

      return loginCall.statusCode == 200;
    } else {
      return false;
    }
  }

  Future<void> fetchUrl(int episodeId) async {
    final fetchCall = await http.head(
        Uri.parse('$mainUrl/podcast/$episodeId'),
        headers: {
          'Cookie': [masterCookie, sessionCookie].join(";"),
        }
    );

    if (fetchCall.statusCode == 401) {
      print("Damn!");
    } else {
      print("Dang!");
    }
  }

  String parseCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];

    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');

      return rawCookie.substring(0, index);
    }

    return "";
  }
}
