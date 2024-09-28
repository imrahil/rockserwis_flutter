import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/screens/login.dart';
import 'package:rockserwis_podcaster/screens/podcasts_page.dart';
import 'package:rockserwis_podcaster/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final prefs = await SharedPreferences.getInstance();
  bool rememberMe = prefs.getBool('rememberMe') ?? false;

  Provider provider = Provider<API>(create: (_) => API(client: http.Client()));

  if (rememberMe) {
    String masterCookie = prefs.getString('masterCookie') ?? "";
    String sessionCookie = prefs.getString('sessionCookie') ?? "";

    if (masterCookie != "" && sessionCookie != "") {
      provider = Provider<API>(
          create: (_) => API(
              client: http.Client(),
              masterCookie: masterCookie,
              sessionCookie: sessionCookie));
    }
  }

  Widget homeComp = !rememberMe ? const LoginPage() : const PodcastsPage();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.imrahil.rockserwis.podcaster',
    androidNotificationChannelName: 'Rockserwis.fm Podcast Player',
    androidNotificationOngoing: true,
  );

  runApp(
    MultiProvider(
      providers: [
        provider,
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MusicPlayer(homeComp: homeComp),
    ),
  );
}

class MusicPlayer extends StatelessWidget {
  final Widget homeComp;

  const MusicPlayer({super.key, required this.homeComp});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Rockserwis.fm Podcast Player',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDarkMode ? darkTheme : lightTheme,
      home: homeComp,
    );
  }
}
