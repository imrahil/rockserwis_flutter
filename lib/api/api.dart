import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'api.g.dart';

class ApiRepository {
  ApiRepository({required this.client, required this.sharedPreferences});

  static const mainUrl = 'https://rockserwis.fm';
  static const broadCastUrl = '$mainUrl/broadcasts.json';
  static const scheduleUrl = '$mainUrl/audycje';
  static const loginCsrfUrl = '$mainUrl/login?get=csrf';
  static const loginPostUrl = '$mainUrl/login';

  static const String favoriteEpisodesKey = 'favoriteEpisodes';
  static const String favoritePodcastsKey = 'favoritePodcasts';

  var logger = Logger();
  http.Client client;
  final SharedPreferences sharedPreferences;

  final Map<String, String> _jsonCache = {};
  final Map<String, DateTime> _cacheLastUpdated = {};

  String _masterCookie = "";
  String _sessionCookie = "";

  bool isLogged() {
    bool rememberMe = sharedPreferences.getBool('rememberMe') ?? false;

    if (rememberMe) {
      _masterCookie = sharedPreferences.getString('masterCookie') ?? "";
      _sessionCookie = sharedPreferences.getString('sessionCookie') ?? "";

      return _masterCookie != "" && _sessionCookie != "";
    }

    return false;
  }

  /// Logs in to the Rockserwis.fm API.
  ///
  /// @param email The user's email address.
  /// @param password The user's password.
  /// @param rememberMe Whether to remember the user's login credentials.
  /// @return True if the login was successful, false otherwise.
  Future<bool> login(String email, String password, bool rememberMe) async {
    logger.d('Logging in... - $loginCsrfUrl');

    final loginCsrf = await client.get(Uri.parse(loginCsrfUrl));

    logger.d('status code: ${loginCsrf.statusCode}');

    if (loginCsrf.statusCode == 200) {
      _masterCookie = _parseCookie(loginCsrf);
      logger.d('csrfTokenCookie: $_masterCookie');

      String loginToken = loginCsrf.body;
      logger.d('loginToken: $loginToken');

      var form = <String, dynamic>{};
      form['csrf-token'] = loginToken;
      form['email'] = email;
      form['password'] = password;
      form['method'] = 'login';

      final loginCall = await client.post(Uri.parse(loginPostUrl),
          body: form, headers: {'Cookie': _masterCookie});

      _sessionCookie = _parseCookie(loginCall);
      logger.d('sessionCookie: $_sessionCookie');

      if (rememberMe) {
        await sharedPreferences.setBool('rememberMe', rememberMe);

        await sharedPreferences.setString('masterCookie', _masterCookie);
        await sharedPreferences.setString('sessionCookie', _sessionCookie);
      }

      return loginCall.statusCode == 200;
    } else {
      logger.d("Something went wrong... login failed!");

      return false;
    }
  }

  /// Logs out of the Rockserwis.fm API.
  Future<void> logout() async {
    await sharedPreferences.setBool('rememberMe', false);
    await sharedPreferences.remove('masterCookie');
    await sharedPreferences.remove('sessionCookie');
  }

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

  /// Gets the URL for a specific episode.
  ///
  /// @param episodeId The ID of the episode.
  /// @return The URL for the episode.
  String getEpisodeUrl(int episodeId) => '$mainUrl/podcast/$episodeId';

  /// Gets the URL for the podcast image.
  ///
  /// @param imageUrl The URL of the podcast image.
  /// @return The URL for the podcast image.
  String getImagePath(String? imageUrl) => '$mainUrl/$imageUrl';

  // Helper function to get the headers for API requests
  Map<String, String> getHeaders() => {
        'Cookie': [_masterCookie, _sessionCookie].join(";")
      };

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

  // Helper function to parse the cookie from the response
  String _parseCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];

    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');

      return rawCookie.substring(0, index);
    }

    return "";
  }
}

@riverpod
ApiRepository apiRepository(ApiRepositoryRef ref) {
  return ApiRepository(
    client: http.Client(),
    sharedPreferences: ref.watch(sharedPreferencesProvider).requireValue,
  );
}
