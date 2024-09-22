import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';
import 'package:rockserwis_podcaster/screens/episodes_page.dart';
import 'package:rockserwis_podcaster/screens/favorite_podcasts_page.dart';
import 'package:rockserwis_podcaster/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PodcastsList extends StatelessWidget {
  final String title;
  final bool showFavorites;
  final Future<List<Podcast>> podcastsFuture;

  const PodcastsList({
    super.key,
    required this.title,
    this.showFavorites = false,
    required this.podcastsFuture,
  });

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', false);
    await prefs.remove('masterCookie');
    await prefs.remove('sessionCookie');

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<API>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: !showFavorites,
        actions: showFavorites
            ? [
                IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoritePodcastsPage()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => _logout(context),
                ),
              ]
            : [],
      ),
      body: FutureBuilder<List<Podcast>>(
          future: podcastsFuture,
          builder:
              (BuildContext context, AsyncSnapshot<List<Podcast>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Podcast currentPodcast = snapshot.data![index];

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: currentPodcast.image != null
                          ? CachedNetworkImage(
                              // Use CachedNetworkImage
                              imageUrl: apiProvider
                                  .getImagePath(currentPodcast.image),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.podcasts),
                      title: Text(
                        currentPodcast.podcastName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Podcast ID: ${currentPodcast.podcastId}'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EpisodesPage(currentPodcast: currentPodcast)),
                        );
                      },
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
