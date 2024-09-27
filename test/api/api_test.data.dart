import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';

final mockPodcasts = [
  {
    "broadcast_id": 64,
    "broadcast_name": "Będzie głłośno",
    "broadcast_broadcasters": [
      {"name": "Mateusz Jagiełło", "is_guest": false}
    ],
    "broadcast_times": [
      {"weekday": 4, "start": "20:00:00", "end": "21:00:00"}
    ],
    "music_only": false,
    "podcasts_active": true,
    "has_podcasts": true,
    "image": "/static/media/broadcasts/będzie-głłośno_1000x1000.jpg"
  },
  {
    "broadcast_id": 70,
    "broadcast_name": "DARKMODE",
    "broadcast_broadcasters": [
      {"name": "Baśnia", "is_guest": false}
    ],
    "broadcast_times": [
      {"weekday": 5, "start": "21:00:00", "end": "23:00:00"}
    ],
    "music_only": false,
    "podcasts_active": true,
    "has_podcasts": true,
    "image": "/static/media/broadcasts/darkmode_1000x1000.jpg"
  },
  {
    "broadcast_id": 34,
    "broadcast_name": "Doctor, Doctor",
    "broadcast_broadcasters": [
      {"name": "Piotr Guzik", "is_guest": false}
    ],
    "broadcast_times": [
      {"weekday": 5, "start": "19:00:00", "end": "21:00:00"}
    ],
    "music_only": false,
    "podcasts_active": true,
    "has_podcasts": true,
    "image": "/static/media/broadcasts/doctor-doctor_1000x1000.jpg"
  },
  {
    "broadcast_id": 8,
    "broadcast_name": "Epoka Żelaza",
    "broadcast_broadcasters": [
      {"name": "Julia Miodyńska", "is_guest": false}
    ],
    "broadcast_times": [
      {"weekday": 0, "start": "19:00:00", "end": "21:00:00"}
    ],
    "music_only": false,
    "podcasts_active": true,
    "has_podcasts": true,
    "image": "/static/media/broadcasts/epoka-żelaza_1000x1000.jpg"
  }
];

final List<Podcast> parsedMockPodcasts =
    mockPodcasts.map((podcast) => Podcast.fromJson(podcast)).toList();

final List<Podcast> podcastsWithoutImages = mockPodcasts.map((podcastData) {
  return Podcast.fromJson({
    ...podcastData,
    'image': "",
  });
}).toList();

final mockEpisodes = [
  {
    "schedule_id": 21359,
    "number": null,
    "date": "2024-09-22",
    "name": "Odgłosy z Ukrytej Grani",
    "img_path":
        "/static/media/schedules/21000/odgłosy-z-ukrytej-grani_1000x1000_21359.jpg",
    "playlist_path": null,
    "has_podcast": true,
    "podcast_duration": 3596.52,
    "number_str": null
  },
  {
    "schedule_id": 21284,
    "number": null,
    "date": "2024-09-15",
    "name": "Odg\u0142osy z Ukrytej Grani",
    "img_path":
        "/static/media/schedules/21000/odgłosy-z-ukrytej-grani_1000x1000_21284.jpg",
    "playlist_path": null,
    "has_podcast": true,
    "podcast_duration": 3596.62,
    "number_str": null
  }
];

final List<Episode> parsedMockEpisodes =
    mockEpisodes.map((episode) => Episode.fromJson(episode)).toList();

final List<Episode> episodesWithoutImages = mockEpisodes.map((episodeData) {
  return Episode.fromJson({
    ...episodeData,
    'img_path': "",
  });
}).toList();
