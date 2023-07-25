import 'package:flutter/material.dart';
import 'package:music_player/api/api.dart';
import 'package:music_player/screens/login.dart';

void main() {
  runApp(MusicPlayer());
}

class MusicPlayer extends StatelessWidget {
  MusicPlayer({super.key});

  final API apiProvider = API();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rockserwis.fm Podcast Player',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 18, fontFamily: 'Hind'),
        ),
      ),
      home: LoginPage(apiProvider: apiProvider),
    );
  }
}