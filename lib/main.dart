import 'package:flutter/material.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/screens/login.dart';

void main() => runApp(MusicPlayer());

class MusicPlayer extends StatelessWidget {
  MusicPlayer({super.key});

  final API apiProvider = API();

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
      home: LoginPage(apiProvider: apiProvider),
    );
  }
}
