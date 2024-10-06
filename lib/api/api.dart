import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/const.dart';
import 'package:rockserwis_podcaster/utils/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'api.g.dart';

class ApiRepository {
  ApiRepository({required this.client, required this.sharedPreferences});

  static const String favoriteEpisodesKey = 'favoriteEpisodes';
  static const String favoritePodcastsKey = 'favoritePodcasts';

  var logger = Logger();
  final http.Client client;
  final SharedPreferences sharedPreferences;

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
    logger.d('Logging in... - ${Const.loginCsrfUrl}');

    final loginCsrf = await client.get(Uri.parse(Const.loginCsrfUrl));

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

      final loginCall = await client.post(Uri.parse(Const.loginPostUrl),
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

  /// Gets the URL for the podcast image.
  ///
  /// @param imageUrl The URL of the podcast image.
  /// @return The URL for the podcast image.
  String getImagePath(String? imageUrl) => '${Const.mainUrl}/$imageUrl';

  // Helper function to get the headers for API requests
  Map<String, String> getHeaders() => {
        'Cookie': [_masterCookie, _sessionCookie].join(";")
      };

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

@Riverpod(keepAlive: true)
ApiRepository apiRepository(ApiRepositoryRef ref) {
  return ApiRepository(
    client: http.Client(),
    sharedPreferences: ref.watch(sharedPreferencesProvider).requireValue,
  );
}
