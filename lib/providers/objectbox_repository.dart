import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/models/podcast.dart';

import '../objectbox.g.dart';

part 'objectbox_repository.g.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;
  late final Box<Podcast> podcastBox;
  late final Box<Episode> episodeBox;

  ObjectBox._create(this.store) {
    podcastBox = Box<Podcast>(store);
    episodeBox = Box<Episode>(store);
  }
}

@Riverpod(keepAlive: true)
Future<ObjectBox> objectBox(ObjectBoxRef ref) async {
  final docsDir = await getApplicationDocumentsDirectory();

  final store =
      await openStore(directory: p.join(docsDir.path, "rockcaster-db"));

  return ObjectBox._create(store);
}
