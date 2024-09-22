import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/screens/favorite_episodes_page.dart';
import 'package:rockserwis_podcaster/screens/login.dart';
import 'package:rockserwis_podcaster/screens/player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EpisodesList extends StatelessWidget {
  final String title;
  final bool showFavorites;
  final Future<List<Episode>> episodesFuture;

  const EpisodesList({
    super.key,
    required this.title,
    this.showFavorites = false,
    required this.episodesFuture,
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
        actions: [
          showFavorites
              ? IconButton(
                  icon: const Icon(Icons.favorite),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoritesEpisodesPage()),
                    );
                  },
                )
              : const Spacer(),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: FutureBuilder<List<Episode>>(
          future: episodesFuture,
          builder:
              (BuildContext context, AsyncSnapshot<List<Episode>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Episode currentEpisode = snapshot.data![index];

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: currentEpisode.imgPath != null
                          ? CachedNetworkImage(
                              // Use CachedNetworkImage
                              imageUrl: apiProvider
                                  .getImagePath(currentEpisode.imgPath),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : const Icon(Icons.podcasts),
                      title: Text(
                        currentEpisode.getEpisodeTitle(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Podcast duration: ${currentEpisode.getReadableDuration()}'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        if (currentEpisode.hasPodcast) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Player(currentEpisode: currentEpisode)),
                          );
                        }
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
