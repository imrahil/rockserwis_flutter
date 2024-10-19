import 'package:flutter/material.dart';
import 'package:rockserwis_podcaster/components/shared_app_bar.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(title: 'History'),
      body: const Center(
        child: Text('History'),
      ),
    );
  }
}
