import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/api/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_test.mocks.dart';

// Generate a mock client
@GenerateMocks([http.Client])
void main() {
  group('API', () {
    late ApiRepository api;
    late MockClient mockClient;

    setUp(() async {
      mockClient = MockClient();
      SharedPreferences.setMockInitialValues({});

      final sharedPreferences = await SharedPreferences.getInstance();

      api = ApiRepository(
        client: mockClient,
        sharedPreferences: sharedPreferences,
      );
    });

    group('isLogged', () {
      test('isLogged', () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('rememberMe', true);
        await prefs.setString('masterCookie', 'test_master_cookie');
        await prefs.setString('sessionCookie', 'test_session_cookie');

        expect(api.isLogged(), true);

        await prefs.setBool('rememberMe', false);

        expect(api.isLogged(), false);
      });
    });

    group('login', () {
      test('returns true when login is successful', () async {
        when(mockClient.get(Uri.parse(Const.loginCsrfUrl))).thenAnswer(
            (_) async => http.Response('test_csrf_token', 200, headers: {
                  'content-type': 'application/json; charset=utf-8',
                  'set-cookie':
                      'csrftoken=test_csrf_cookie;session=test_session_cookie'
                }));

        when(mockClient.post(Uri.parse(Const.loginPostUrl),
                body: anyNamed('body'), headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('', 200, headers: {
                  'content-type': 'application/json; charset=utf-8',
                  'set-cookie':
                      'sessionid=test_session_cookie;session=test_session_cookie'
                }));

        final result = await api.login('test@email.com', 'password', false);

        expect(result, true);
        expect(api.getHeaders(), {
          'Cookie': 'csrftoken=test_csrf_cookie;sessionid=test_session_cookie'
        });

        await api.login('test@email.com', 'password', true);

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getBool('rememberMe'), true);
      });

      test('returns false when login is unsuccessful', () async {
        when(mockClient.get(Uri.parse(Const.loginCsrfUrl)))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        final result = await api.login('test@email.com', 'password', false);

        expect(result, false);
      });

      test('returns true when login is with rememberMe', () async {
        when(mockClient.get(Uri.parse(Const.loginCsrfUrl))).thenAnswer(
            (_) async => http.Response('test_csrf_token', 200, headers: {
                  'content-type': 'application/json; charset=utf-8',
                  'set-cookie':
                      'csrftoken=test_csrf_cookie;session=test_session_cookie'
                }));

        when(mockClient.post(Uri.parse(Const.loginPostUrl),
                body: anyNamed('body'), headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('', 200, headers: {
                  'content-type': 'application/json; charset=utf-8',
                  'set-cookie':
                      'sessionid=test_session_cookie;session=test_session_cookie'
                }));

        final result = await api.login('test@email.com', 'password', true);

        expect(result, true);

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getBool('rememberMe'), true);
        expect(prefs.getString('masterCookie'), 'csrftoken=test_csrf_cookie');
        expect(
            prefs.getString('sessionCookie'), 'sessionid=test_session_cookie');
      });
    });

    group('logout', () {
      test('clears cookies and SharedPreferences', () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('rememberMe', true);
        await prefs.setString('masterCookie', 'test_master_cookie');
        await prefs.setString('sessionCookie', 'test_session_cookie');

        await api.logout();

        expect(prefs.getBool('rememberMe'), false);
        expect(prefs.getString('masterCookie'), null);
        expect(prefs.getString('sessionCookie'), null);
      });
    });

    group('getImagePath', () {
      test('returns the correct image path', () {
        const imageUrl = 'images/test.jpg';
        const expectedPath = '${Const.mainUrl}/$imageUrl';
        expect(api.getImagePath(imageUrl), expectedPath);
      });
    });
  });
}
