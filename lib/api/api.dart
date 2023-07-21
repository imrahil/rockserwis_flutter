import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_player/models/schedule.dart';
import '../models/broadcast.dart';

const mainUrl = 'https://rockserwis.fm';
const broadCastUrl = '$mainUrl/broadcasts.json';
const scheduleUrl = '$mainUrl/audycje';

class API {
  static Future<List<Broadcast>> getBroadcasts() async {
    final response = await http
        .get(Uri.parse(broadCastUrl));

    if (response.statusCode == 200) {
      List<Broadcast> broadcastList;
      broadcastList = (json.decode(response.body) as List)
          .map((i) => Broadcast.fromJson(i))
          .toList();

      return broadcastList;
    } else {
      throw Exception('Failed to load broadcasts...');
    }
  }

  static Future<List<Schedule>> getSchedules(int broadcastId) async {
    String url = '$scheduleUrl/$broadcastId.json';

    final response = await http
        .get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Schedule> scheduleList;
      scheduleList = (json.decode(response.body) as List)
          .map((i) => Schedule.fromJson(i))
          .toList();

      return scheduleList;
    } else {
      throw Exception('Failed to load schedules...');
    }
  }
}