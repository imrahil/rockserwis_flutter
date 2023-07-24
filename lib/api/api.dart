import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_player/models/episode.dart';
import '../models/podcast.dart';

const mainUrl = 'https://rockserwis.fm';
const broadCastUrl = '$mainUrl/broadcasts.json';
const scheduleUrl = '$mainUrl/audycje';

class API {
  static Future<List<Podcast>> getPodcasts() async {
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

  static Future<List<Episode>> getEpisodes(int broadcastId) async {
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
}
