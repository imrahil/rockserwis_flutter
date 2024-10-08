import 'package:intl/intl.dart';
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

  bool? isFavorited;

  // Static factory method
  static EpisodeDB createItem({
    int? id,
    int? episodeId,
    int? podcastId,
    DateTime? date,
    String? name,
    String? imgPath,
    double? episodeDuration,
    bool? hasPodcast,
  }) {
    final episode = EpisodeDB();

    episode.id = id!;
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
      id: 0,
      episodeId: episode.episodeId,
      podcastId: podcastId,
      date: episode.date,
      name: episode.name,
      imgPath: episode.imgPath,
      episodeDuration: episode.episodeDuration,
      hasPodcast: episode.hasPodcast,
    );
  }

  copyWith({required bool isFavorited}) {
    return EpisodeDB.createItem(
      id: id,
      episodeId: episodeId,
      podcastId: podcastId,
      date: date,
      name: name,
      imgPath: imgPath,
      episodeDuration: episodeDuration,
      hasPodcast: hasPodcast,
    )..isFavorited = isFavorited;
  }

  String getEpisodeTitle() {
    String episodeTitle = "$name - ${DateFormat("yyyy-MM-dd").format(date!)}";

    return episodeTitle;
  }

  String getReadableDuration() {
    if (episodeDuration == null) {
      return "Unknown duration";
    }

    int totalSeconds = episodeDuration!.toInt();
    int minutes = (totalSeconds / 60).round();

    return "$minutes min";
  }
}
