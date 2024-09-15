import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/screens/login.dart';
import 'package:rockserwis_podcaster/screens/podcasts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  bool rememberMe = prefs.getBool('rememberMe') ?? false;

  Provider provider = Provider<API>(create: (_) => API());

  if (rememberMe) {
    String masterCookie = prefs.getString('masterCookie') ?? "";
    String sessionCookie = prefs.getString('sessionCookie') ?? "";

    if (masterCookie != "" && sessionCookie != "") {
      provider = Provider<API>(
          create: (_) =>
              API(masterCookie: masterCookie, sessionCookie: sessionCookie));
    }
  }

  Widget homeComp = !rememberMe ? const LoginPage() : const PodcastsPage();

  runApp(
    MultiProvider(
      providers: [
        provider,
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
    return MaterialApp(
      title: 'Rockserwis.fm Podcast Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark, // Enable dark theme
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[850], // Dark background for input fields
          labelStyle:
              TextStyle(color: Colors.grey[400]), // Light text color for labels
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[600]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[600]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
      ),
      home: homeComp,
    );
  }
}
