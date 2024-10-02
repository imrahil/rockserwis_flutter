import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/models/episode.dart';

part 'api_new.g.dart';

class ApiRepository {
  static const mainUrl = 'https://rockserwis.fm';
  static const broadCastUrl = '$mainUrl/broadcasts.json';
  static const scheduleUrl = '$mainUrl/audycje';
  static const loginCsrfUrl = '$mainUrl/login?get=csrf';
  static const loginPostUrl = '$mainUrl/login';

  static const String favoriteEpisodesKey = 'favoriteEpisodes';
  static const String favoritePodcastsKey = 'favoritePodcasts';

  var logger = Logger();
  http.Client client;

  List<Episode> selectedPodcastEpisodes = [];

  final Map<String, String> _jsonCache = {};
  final Map<String, DateTime> _cacheLastUpdated = {};

  ApiRepository({required this.client});

  /// Fetches JSON data from the given URL and caches it.
  ///
  /// @param url The URL to fetch data from.
  /// @param parser A function that parses the JSON data into the desired format.
  /// @param forceRefresh Whether to force a refresh from the network, even if data is in the cache.
  /// @return The parsed JSON data.
  Future<dynamic> fetchAndCacheJson(String url, Function(String) parser,
      {bool forceRefresh = false}) async {
    // Check if data is in the cache and not being forced to refresh
    if (_jsonCache.containsKey(url) && !forceRefresh && _shouldUseCache(url)) {
      logger.d('Loading from cache: $url');
      return parser(_jsonCache[url]!);
    }

    // If not in cache, fetch from network
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      logger.d('Loading from network: $url');
      final jsonData = response.body;

      // Cache the JSON data and update last fetched time
      _jsonCache[url] = jsonData;
      _cacheLastUpdated[url] = DateTime.now();

      return parser(jsonData);
    } else {
      throw Exception('Failed to load data from: $url');
    }
  }

  /// Helper function to determine if the cache should be used
  bool _shouldUseCache(String url) {
    // Cache for 2 hour
    const cacheDuration = Duration(hours: 2);

    if (!_cacheLastUpdated.containsKey(url)) {
      return false;
    }

    final lastUpdated = _cacheLastUpdated[url]!;
    final now = DateTime.now();

    return now.difference(lastUpdated) < cacheDuration;
  }

  /// Gets the URL for the podcast image.
  ///
  /// @param imageUrl The URL of the podcast image.
  /// @return The URL for the podcast image.
  String getImagePath(String? imageUrl) => '$mainUrl/$imageUrl';
}

@riverpod
ApiRepository apiRepository(ApiRepositoryRef ref) =>
    ApiRepository(client: http.Client());
