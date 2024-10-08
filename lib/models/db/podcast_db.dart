import 'package:objectbox/objectbox.dart';
import 'package:rockserwis_podcaster/models/db/author_db.dart';
import 'package:rockserwis_podcaster/models/db/schedule_db.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';

@Entity()
class PodcastDB {
  int id = 0;

  int? podcastId;
  String? podcastName;
  final authors = ToMany<AuthorDB>();
  final schedules = ToMany<ScheduleDB>();
  bool? onlyMusic;
  bool? isActive;
  bool? hasEpisodes;
  String? image;

  bool? isFavorited;

  // Static factory method
  static PodcastDB createItem({
    int? id,
    int? podcastId,
    String? podcastName,
    List<AuthorDB>? authors,
    List<ScheduleDB>? schedules,
    bool? onlyMusic,
    bool? isActive,
    bool? hasEpisodes,
    String? image,
  }) {
    final podcast = PodcastDB();

    podcast.id = id!;
    podcast.podcastId = podcastId;
    podcast.podcastName = podcastName;
    if (authors != null) {
      podcast.authors.addAll(authors);
    }
    if (schedules != null) {
      podcast.schedules.addAll(schedules);
    }
    podcast.onlyMusic = onlyMusic;
    podcast.isActive = isActive;
    podcast.hasEpisodes = hasEpisodes;
    podcast.image = image;

    return podcast;
  }

  // Method to convert Podcast to PodcastDB
  static PodcastDB fromPodcast(Podcast podcast) {
    return PodcastDB.createItem(
      id: 0,
      podcastId: podcast.podcastId,
      podcastName: podcast.podcastName,
      authors:
          podcast.authors.map((author) => AuthorDB.fromAuthor(author)).toList(),
      schedules: podcast.schedules
          .map((schedule) => ScheduleDB.fromSchedule(schedule))
          .toList(),
      onlyMusic: podcast.onlyMusic,
      isActive: podcast.isActive,
      hasEpisodes: podcast.hasEpisodes,
      image: podcast.image,
    );
  }

  copyWith({required bool isFavorited}) {
    return PodcastDB.createItem(
      id: id,
      podcastId: podcastId,
      podcastName: podcastName,
      authors: authors.toList(),
      schedules: schedules.toList(),
      onlyMusic: onlyMusic,
      isActive: isActive,
      hasEpisodes: hasEpisodes,
      image: image,
    )..isFavorited = isFavorited;
  }
}
