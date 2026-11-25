import 'package:audio_service/audio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:objectbox/objectbox.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/utils/media_library.dart';

void main() {
  final neverPlayed = DateTime.utc(2000, 1, 1);
  final now = DateTime.now();

  Podcast podcast(int id, String name, {bool favorited = false}) => Podcast(
    podcastId: id,
    podcastName: name,
    authors: ToMany(),
    schedules: ToMany(),
    onlyMusic: false,
    isActive: true,
    hasEpisodes: true,
    image: 'img/$id.jpg',
    isFavorited: favorited,
  );

  Episode episode(
    int id, {
    required int podcastId,
    required DateTime date,
    String? name,
    DateTime? updatedAt,
    bool favorited = false,
    int progress = 0,
    int total = 0,
  }) => Episode(
    episodeId: id,
    podcastId: podcastId,
    date: date,
    name: name ?? 'Show $podcastId',
    hasPodcast: true,
    episodeDuration: 3600,
    imgPath: 'ep/$id.jpg',
    updatedAt: updatedAt ?? neverPlayed,
    isFavorited: favorited,
    progress: progress,
    total: total,
  );

  late List<Podcast> podcasts;
  late List<Episode> episodes;
  late List<Episode> played;
  late bool loggedIn;
  late MediaLibrary library;

  setUp(() {
    podcasts = [
      podcast(1, 'Zeta', favorited: true),
      podcast(2, 'Alpha'),
      podcast(3, 'No episodes', favorited: true),
    ];
    episodes = [
      episode(10, podcastId: 1, date: DateTime(2026, 1, 1)),
      episode(
        11,
        podcastId: 1,
        date: DateTime(2026, 2, 1),
        updatedAt: now.subtract(const Duration(days: 1)),
        progress: 600000,
        total: 3600000,
      ),
      episode(
        20,
        podcastId: 2,
        date: DateTime(2026, 3, 1),
        updatedAt: now.subtract(const Duration(hours: 1)),
        favorited: true,
        progress: 3600000,
        total: 3600000,
      ),
      episode(
        21,
        podcastId: 2,
        date: DateTime(2025, 3, 1),
        updatedAt: now.subtract(const Duration(days: 30)),
      ),
    ];
    played = [];
    loggedIn = true;
    library = MediaLibrary(
      loadPodcasts: () async => podcasts,
      loadEpisodes: () async => episodes,
      imageUrl: (path) => 'https://example.test/$path',
      isLoggedIn: () => loggedIn,
      playEpisode: (episode) async => played.add(episode),
    );
  });

  List<String> ids(List<MediaItem> items) => items.map((i) => i.id).toList();

  group('getChildren', () {
    test('root lists the four browsable tabs', () async {
      final root = await library.getChildren(AudioService.browsableRootId);

      expect(ids(root), [
        MediaLibrary.recentEpisodesId,
        MediaLibrary.favoriteEpisodesId,
        MediaLibrary.favoritePodcastsId,
        MediaLibrary.allPodcastsId,
      ]);
      expect(root.every((item) => item.playable == false), isTrue);
    });

    test('root asks to sign in when logged out', () async {
      loggedIn = false;

      final root = await library.getChildren(AudioService.browsableRootId);

      expect(ids(root), [MediaLibrary.signInId]);
    });

    test('recent root holds only the last played episode', () async {
      final recent = await library.getChildren(AudioService.recentRootId);

      expect(ids(recent), ['episode:20']);
    });

    test('recent tab lists episodes played in the last 10 days', () async {
      final recent = await library.getChildren(MediaLibrary.recentEpisodesId);

      expect(ids(recent), ['episode:20', 'episode:11']);
    });

    test('favourite episodes tab lists favourited episodes', () async {
      final favorites = await library.getChildren(
        MediaLibrary.favoriteEpisodesId,
      );

      expect(ids(favorites), ['episode:20']);
    });

    test('podcast tabs list folders with episodes, sorted by name', () async {
      final all = await library.getChildren(MediaLibrary.allPodcastsId);
      final favorites = await library.getChildren(
        MediaLibrary.favoritePodcastsId,
      );

      expect(ids(all), ['podcast:2', 'podcast:1']);
      expect(ids(favorites), ['podcast:1']);
      expect(all.first.playable, isFalse);
      expect(all.first.artUri.toString(), 'https://example.test/img/2.jpg');
    });

    test('podcast folder lists its episodes newest first', () async {
      final items = await library.getChildren('podcast:1');

      expect(ids(items), ['episode:11', 'episode:10']);
      expect(items.every((item) => item.playable == true), isTrue);
    });

    test('unknown IDs have no children', () async {
      expect(await library.getChildren('podcast:999'), isEmpty);
      expect(await library.getChildren('nonsense'), isEmpty);
    });
  });

  group('episode items', () {
    test('carry title, date, duration and artwork', () {
      final item = library.episodeToMediaItem(episodes[0]);

      expect(item.id, 'episode:10');
      expect(item.title, 'Show 1');
      expect(item.album, '2026-01-01');
      expect(item.displaySubtitle, '2026-01-01 · 60 min');
      expect(item.duration, const Duration(hours: 1));
      expect(item.artUri.toString(), 'https://example.test/ep/10.jpg');
    });

    test('report completion status for Android Auto', () {
      const status = 'android.media.extra.PLAYBACK_STATUS';
      const percentage =
          'androidx.media.MediaItem.Extras.COMPLETION_PERCENTAGE';

      expect(library.episodeToMediaItem(episodes[0]).extras, {status: 0});
      expect(library.episodeToMediaItem(episodes[2]).extras, {status: 2});

      final partial = library.episodeToMediaItem(episodes[1]).extras!;
      expect(partial[status], 1);
      expect(partial[percentage], closeTo(1 / 6, 1e-9));
    });
  });

  group('playback', () {
    test('playFromMediaId plays the matching episode', () async {
      expect(await library.playFromMediaId('episode:21'), isTrue);
      // Bare IDs, as used by earlier versions, still resolve.
      expect(await library.playFromMediaId('10'), isTrue);
      expect(await library.playFromMediaId('episode:999'), isFalse);

      expect(played.map((e) => e.episodeId), [21, 10]);
    });

    test('getMediaItem finds episodes', () async {
      expect((await library.getMediaItem('episode:11'))?.title, 'Show 1');
      expect(await library.getMediaItem('podcast:1'), isNull);
    });

    test('empty voice query resumes the last played episode', () async {
      expect(await library.playFromSearch(''), isTrue);

      expect(played.single.episodeId, 20);
    });

    test(
      'voice query plays the newest episode of a matching podcast',
      () async {
        expect(await library.playFromSearch('zeta'), isTrue);

        expect(played.single.episodeId, 11);
      },
    );

    test('voice query without a match plays nothing', () async {
      expect(await library.playFromSearch('jazz'), isFalse);

      expect(played, isEmpty);
    });

    test('playLastPlayed does nothing when nothing was played', () async {
      episodes = [episode(1, podcastId: 1, date: DateTime(2026, 1, 1))];

      expect(await library.playLastPlayed(), isFalse);
      expect(played, isEmpty);
    });
  });
}
