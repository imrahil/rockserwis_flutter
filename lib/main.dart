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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(apiProvider: apiProvider),
    );
  }
}