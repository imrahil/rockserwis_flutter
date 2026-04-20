import 'dart:async';
import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rockserwis_podcaster/api/api.dart';
import 'package:rockserwis_podcaster/models/episode.dart';
import 'package:rockserwis_podcaster/providers/download_settings.dart';
import 'package:rockserwis_podcaster/providers/episode_repository.dart';
import 'package:rockserwis_podcaster/utils/logger.dart';

part 'download_repository.g.dart';

class DownloadRepository {
  DownloadRepository({required this.ref}) {
    _init();
  }

  final Ref ref;
  final FileDownloader _downloader = FileDownloader();

  final Map<int, StreamController<double>> _progressControllers = {};
  final Map<int, String> _taskToEpisodeId = {};

  void _init() {
    _downloader.updates.listen(_handleUpdate);
  }

  Stream<double> progressStream(int episodeId) {
    return _progressControllers
        .putIfAbsent(episodeId, () => StreamController<double>.broadcast())
        .stream;
  }

  String _taskIdFor(int episodeId) => 'episode_$episodeId';

  Future<String> _downloadsDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final downloads = Directory(p.join(dir.path, 'downloads'));
    if (!await downloads.exists()) {
      await downloads.create(recursive: true);
    }
    return downloads.path;
  }

  Future<void> downloadEpisode(Episode episode) async {
    final settings = ref.read(downloadSettingsProvider);
    if (!settings.downloadsEnabled) {
      logger.w('Downloads are disabled in settings');
      return;
    }

    await _evictToFitNewDownload();

    final apiProvider = ref.read(apiRepositoryProvider);
    final dir = await _downloadsDir();
    final filename = 'episode_${episode.episodeId}.mp3';

    final task = DownloadTask(
      taskId: _taskIdFor(episode.episodeId),
      url: episode.getEpisodeUrl,
      headers: apiProvider.getHeaders(),
      filename: filename,
      baseDirectory: BaseDirectory.applicationDocuments,
      directory: 'downloads',
      updates: Updates.statusAndProgress,
      requiresWiFi: settings.wifiOnly,
      allowPause: true,
      retries: 3,
    );

    _taskToEpisodeId[episode.episodeId] =
        p.join(dir, filename); // track expected path

    await _downloader.enqueue(task);
  }

  Future<void> cancelDownload(int episodeId) async {
    await _downloader.cancelTaskWithId(_taskIdFor(episodeId));
    _progressControllers[episodeId]?.add(-1);
  }

  Future<void> deleteDownload(Episode episode) async {
    await cancelDownload(episode.episodeId);

    if (episode.downloadedPath != null) {
      final file = File(episode.downloadedPath!);
      if (await file.exists()) {
        await file.delete();
      }
    }

    await ref
        .read(allEpisodesProvider.notifier)
        .updateDownloadedPath(episode.episodeId, null);
  }

  void _handleUpdate(TaskUpdate update) {
    final episodeId = _parseEpisodeId(update.task.taskId);
    if (episodeId == null) return;

    if (update is TaskProgressUpdate) {
      _progressControllers[episodeId]?.add(update.progress);
    } else if (update is TaskStatusUpdate) {
      switch (update.status) {
        case TaskStatus.complete:
          _onComplete(episodeId, update.task);
          break;
        case TaskStatus.failed:
        case TaskStatus.canceled:
        case TaskStatus.notFound:
          _progressControllers[episodeId]?.add(-1);
          logger.w(
              'Download ${update.status.name} for episode $episodeId: ${update.exception}');
          break;
        default:
          break;
      }
    }
  }

  Future<void> _onComplete(int episodeId, Task task) async {
    final downloadTask = task as DownloadTask;
    final filePath = await downloadTask.filePath();
    _progressControllers[episodeId]?.add(1.0);
    await ref
        .read(allEpisodesProvider.notifier)
        .updateDownloadedPath(episodeId, filePath);
    logger.i('Download complete for episode $episodeId at $filePath');
  }

  Future<int> currentUsageBytes() async {
    final episodes = await ref.read(allEpisodesProvider.future);
    int total = 0;
    for (final ep in episodes) {
      final path = ep.downloadedPath;
      if (path == null) continue;
      final file = File(path);
      if (await file.exists()) {
        total += await file.length();
      }
    }
    return total;
  }

  /// Evicts oldest-played downloads until there is room for another ~150 MB file.
  /// A no-op when max storage is 0 (unlimited).
  Future<void> _evictToFitNewDownload() async {
    const estimatedFileBytes = 150 * 1024 * 1024;
    final settings = ref.read(downloadSettingsProvider);
    if (settings.maxStorageMb <= 0) return;

    final maxBytes = settings.maxStorageMb * 1024 * 1024;
    int current = await currentUsageBytes();
    if (current + estimatedFileBytes <= maxBytes) return;

    final episodes = await ref.read(allEpisodesProvider.future);
    final candidates = episodes
        .where((e) => e.downloadedPath != null)
        .toList()
      ..sort((a, b) => (a.updatedAt ?? DateTime.utc(2000, 1, 1))
          .compareTo(b.updatedAt ?? DateTime.utc(2000, 1, 1)));

    for (final ep in candidates) {
      if (current + estimatedFileBytes <= maxBytes) break;
      final file = File(ep.downloadedPath!);
      final size = await file.exists() ? await file.length() : 0;
      await deleteDownload(ep);
      current -= size;
      logger.i('Evicted download for episode ${ep.episodeId} to free space');
    }
  }

  /// Enqueues auto-downloads for new episodes if the setting is enabled.
  Future<void> autoDownloadEpisodes(List<Episode> episodes) async {
    final settings = ref.read(downloadSettingsProvider);
    if (!settings.downloadsEnabled || !settings.autoDownloadFavorites) return;
    if (episodes.isEmpty) return;

    logger.i('Auto-downloading ${episodes.length} new favorited episodes');
    for (final ep in episodes) {
      await downloadEpisode(ep);
    }
  }

  int? _parseEpisodeId(String taskId) {
    if (!taskId.startsWith('episode_')) return null;
    return int.tryParse(taskId.substring('episode_'.length));
  }
}

@Riverpod(keepAlive: true)
DownloadRepository downloadRepository(Ref ref) {
  return DownloadRepository(ref: ref);
}

@riverpod
Stream<double> downloadProgress(Ref ref, int episodeId) {
  return ref.watch(downloadRepositoryProvider).progressStream(episodeId);
}
