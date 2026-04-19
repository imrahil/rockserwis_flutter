// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(episodeRepository)
final episodeRepositoryProvider = EpisodeRepositoryProvider._();

final class EpisodeRepositoryProvider
    extends
        $FunctionalProvider<
          EpisodeRepository,
          EpisodeRepository,
          EpisodeRepository
        >
    with $Provider<EpisodeRepository> {
  EpisodeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'episodeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$episodeRepositoryHash();

  @$internal
  @override
  $ProviderElement<EpisodeRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EpisodeRepository create(Ref ref) {
    return episodeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EpisodeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EpisodeRepository>(value),
    );
  }
}

String _$episodeRepositoryHash() => r'ee90ae0b41c357aca8aa0f4f456d16bd2b09124d';

@ProviderFor(fetchEpisodes)
final fetchEpisodesProvider = FetchEpisodesFamily._();

final class FetchEpisodesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Episode>>,
          List<Episode>,
          FutureOr<List<Episode>>
        >
    with $FutureModifier<List<Episode>>, $FutureProvider<List<Episode>> {
  FetchEpisodesProvider._({
    required FetchEpisodesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'fetchEpisodesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchEpisodesHash();

  @override
  String toString() {
    return r'fetchEpisodesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Episode>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Episode>> create(Ref ref) {
    final argument = this.argument as int;
    return fetchEpisodes(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchEpisodesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchEpisodesHash() => r'e97576f984cd9893d2bceb7ea556d333e89c13f3';

final class FetchEpisodesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Episode>>, int> {
  FetchEpisodesFamily._()
    : super(
        retry: null,
        name: r'fetchEpisodesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchEpisodesProvider call(int podcastId) =>
      FetchEpisodesProvider._(argument: podcastId, from: this);

  @override
  String toString() => r'fetchEpisodesProvider';
}

@ProviderFor(AllEpisodes)
final allEpisodesProvider = AllEpisodesProvider._();

final class AllEpisodesProvider
    extends $AsyncNotifierProvider<AllEpisodes, List<Episode>> {
  AllEpisodesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allEpisodesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allEpisodesHash();

  @$internal
  @override
  AllEpisodes create() => AllEpisodes();
}

String _$allEpisodesHash() => r'd9de503333adb6725a79f17c5f85a4a161e46ee7';

abstract class _$AllEpisodes extends $AsyncNotifier<List<Episode>> {
  FutureOr<List<Episode>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Episode>>, List<Episode>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Episode>>, List<Episode>>,
              AsyncValue<List<Episode>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(episodeList)
final episodeListProvider = EpisodeListFamily._();

final class EpisodeListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Episode>>,
          List<Episode>,
          FutureOr<List<Episode>>
        >
    with $FutureModifier<List<Episode>>, $FutureProvider<List<Episode>> {
  EpisodeListProvider._({
    required EpisodeListFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'episodeListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$episodeListHash();

  @override
  String toString() {
    return r'episodeListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Episode>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Episode>> create(Ref ref) {
    final argument = this.argument as int;
    return episodeList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EpisodeListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$episodeListHash() => r'bbb7f8d3dd619bd99f223b950ea34a5e9a4dbc44';

final class EpisodeListFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Episode>>, int> {
  EpisodeListFamily._()
    : super(
        retry: null,
        name: r'episodeListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EpisodeListProvider call(int podcastId) =>
      EpisodeListProvider._(argument: podcastId, from: this);

  @override
  String toString() => r'episodeListProvider';
}

/// Fetches all episodes from the history.

@ProviderFor(historyEpisodes)
final historyEpisodesProvider = HistoryEpisodesProvider._();

/// Fetches all episodes from the history.

final class HistoryEpisodesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Episode>>,
          List<Episode>,
          FutureOr<List<Episode>>
        >
    with $FutureModifier<List<Episode>>, $FutureProvider<List<Episode>> {
  /// Fetches all episodes from the history.
  HistoryEpisodesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyEpisodesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyEpisodesHash();

  @$internal
  @override
  $FutureProviderElement<List<Episode>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Episode>> create(Ref ref) {
    return historyEpisodes(ref);
  }
}

String _$historyEpisodesHash() => r'bd9b189838508fd0035d85419a8a0504aba97d86';

/// Fetches all favorited episodes from the database.

@ProviderFor(favoritedEpisodes)
final favoritedEpisodesProvider = FavoritedEpisodesProvider._();

/// Fetches all favorited episodes from the database.

final class FavoritedEpisodesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Episode>>,
          List<Episode>,
          FutureOr<List<Episode>>
        >
    with $FutureModifier<List<Episode>>, $FutureProvider<List<Episode>> {
  /// Fetches all favorited episodes from the database.
  FavoritedEpisodesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritedEpisodesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritedEpisodesHash();

  @$internal
  @override
  $FutureProviderElement<List<Episode>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Episode>> create(Ref ref) {
    return favoritedEpisodes(ref);
  }
}

String _$favoritedEpisodesHash() => r'b90ebb2495f9af5d79495972f2a654a49254ac84';

@ProviderFor(watchFavoritedEpisode)
final watchFavoritedEpisodeProvider = WatchFavoritedEpisodeFamily._();

final class WatchFavoritedEpisodeProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  WatchFavoritedEpisodeProvider._({
    required WatchFavoritedEpisodeFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'watchFavoritedEpisodeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$watchFavoritedEpisodeHash();

  @override
  String toString() {
    return r'watchFavoritedEpisodeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as int;
    return watchFavoritedEpisode(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchFavoritedEpisodeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$watchFavoritedEpisodeHash() =>
    r'83ac593413671d32d28c030686c12634a5166fb7';

final class WatchFavoritedEpisodeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, int> {
  WatchFavoritedEpisodeFamily._()
    : super(
        retry: null,
        name: r'watchFavoritedEpisodeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WatchFavoritedEpisodeProvider call(int episodeId) =>
      WatchFavoritedEpisodeProvider._(argument: episodeId, from: this);

  @override
  String toString() => r'watchFavoritedEpisodeProvider';
}
