import 'package:objectbox/objectbox.dart';
import 'package:rockserwis_podcaster/models/episode.dart';

@Entity()
class EpisodeDB {
  int id = 0;

  int? episodeId;
  int? podcastId;
  @Property(type: PropertyType.dateNano)
  DateTime? date;
  String? name;
  String? imgPath;
  double? episodeDuration;
  bool? hasPodcast;

  // Static factory method
  static EpisodeDB createItem({
    int? episodeId,
    int? podcastId,
    DateTime? date,
    String? name,
    String? imgPath,
    double? episodeDuration,
    bool? hasPodcast,
  }) {
    final episode = EpisodeDB();

    episode.episodeId = episodeId;
    episode.podcastId = podcastId;
    episode.date = date;
    episode.name = name;
    episode.imgPath = imgPath;
    episode.episodeDuration = episodeDuration;
    episode.hasPodcast = hasPodcast;

    return episode;
  }

  // Method to convert Episode to EpisodeDB
  static EpisodeDB fromEpisode(Episode episode, int podcastId) {
    return EpisodeDB.createItem(
      episodeId: episode.episodeId,
      podcastId: podcastId,
      date: episode.date,
      name: episode.name,
      imgPath: episode.imgPath,
      episodeDuration: episode.episodeDuration,
      hasPodcast: episode.hasPodcast,
    );
  }
}
