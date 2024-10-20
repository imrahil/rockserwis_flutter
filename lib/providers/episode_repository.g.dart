// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$episodeRepositoryHash() => r'17a1f4f5dc9e1d7ffe760b71c80bfb5ad27341ec';

/// See also [episodeRepository].
@ProviderFor(episodeRepository)
final episodeRepositoryProvider =
    AutoDisposeProvider<EpisodeRepository>.internal(
  episodeRepository,
  name: r'episodeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$episodeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EpisodeRepositoryRef = AutoDisposeProviderRef<EpisodeRepository>;
String _$fetchEpisodesHash() => r'767fe513f2fd6772634dce0b098d85a4a05da845';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fetchEpisodes].
@ProviderFor(fetchEpisodes)
const fetchEpisodesProvider = FetchEpisodesFamily();

/// See also [fetchEpisodes].
class FetchEpisodesFamily extends Family<AsyncValue<List<Episode>>> {
  /// See also [fetchEpisodes].
  const FetchEpisodesFamily();

  /// See also [fetchEpisodes].
  FetchEpisodesProvider call(
    int podcastId,
  ) {
    return FetchEpisodesProvider(
      podcastId,
    );
  }

  @override
  FetchEpisodesProvider getProviderOverride(
    covariant FetchEpisodesProvider provider,
  ) {
    return call(
      provider.podcastId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchEpisodesProvider';
}

/// See also [fetchEpisodes].
class FetchEpisodesProvider extends AutoDisposeFutureProvider<List<Episode>> {
  /// See also [fetchEpisodes].
  FetchEpisodesProvider(
    int podcastId,
  ) : this._internal(
          (ref) => fetchEpisodes(
            ref as FetchEpisodesRef,
            podcastId,
          ),
          from: fetchEpisodesProvider,
          name: r'fetchEpisodesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchEpisodesHash,
          dependencies: FetchEpisodesFamily._dependencies,
          allTransitiveDependencies:
              FetchEpisodesFamily._allTransitiveDependencies,
          podcastId: podcastId,
        );

  FetchEpisodesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.podcastId,
  }) : super.internal();

  final int podcastId;

  @override
  Override overrideWith(
    FutureOr<List<Episode>> Function(FetchEpisodesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchEpisodesProvider._internal(
        (ref) => create(ref as FetchEpisodesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        podcastId: podcastId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Episode>> createElement() {
    return _FetchEpisodesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchEpisodesProvider && other.podcastId == podcastId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, podcastId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchEpisodesRef on AutoDisposeFutureProviderRef<List<Episode>> {
  /// The parameter `podcastId` of this provider.
  int get podcastId;
}

class _FetchEpisodesProviderElement
    extends AutoDisposeFutureProviderElement<List<Episode>>
    with FetchEpisodesRef {
  _FetchEpisodesProviderElement(super.provider);

  @override
  int get podcastId => (origin as FetchEpisodesProvider).podcastId;
}

String _$allEpisodesHash() => r'ccacb4c0c178bce6d779dac74c016fac3a637bb9';

/// See also [AllEpisodes].
@ProviderFor(AllEpisodes)
final allEpisodesProvider =
    AutoDisposeAsyncNotifierProvider<AllEpisodes, List<Episode>>.internal(
  AllEpisodes.new,
  name: r'allEpisodesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allEpisodesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AllEpisodes = AutoDisposeAsyncNotifier<List<Episode>>;
String _$episodeListHash() => r'c466db87237d7dede2cd8f5c7d48496852427485';

abstract class _$EpisodeList
    extends BuildlessAutoDisposeAsyncNotifier<List<Episode>> {
  late final int podcastId;

  FutureOr<List<Episode>> build(
    int podcastId,
  );
}

/// See also [EpisodeList].
@ProviderFor(EpisodeList)
const episodeListProvider = EpisodeListFamily();

/// See also [EpisodeList].
class EpisodeListFamily extends Family<AsyncValue<List<Episode>>> {
  /// See also [EpisodeList].
  const EpisodeListFamily();

  /// See also [EpisodeList].
  EpisodeListProvider call(
    int podcastId,
  ) {
    return EpisodeListProvider(
      podcastId,
    );
  }

  @override
  EpisodeListProvider getProviderOverride(
    covariant EpisodeListProvider provider,
  ) {
    return call(
      provider.podcastId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'episodeListProvider';
}

/// See also [EpisodeList].
class EpisodeListProvider
    extends AutoDisposeAsyncNotifierProviderImpl<EpisodeList, List<Episode>> {
  /// See also [EpisodeList].
  EpisodeListProvider(
    int podcastId,
  ) : this._internal(
          () => EpisodeList()..podcastId = podcastId,
          from: episodeListProvider,
          name: r'episodeListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$episodeListHash,
          dependencies: EpisodeListFamily._dependencies,
          allTransitiveDependencies:
              EpisodeListFamily._allTransitiveDependencies,
          podcastId: podcastId,
        );

  EpisodeListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.podcastId,
  }) : super.internal();

  final int podcastId;

  @override
  FutureOr<List<Episode>> runNotifierBuild(
    covariant EpisodeList notifier,
  ) {
    return notifier.build(
      podcastId,
    );
  }

  @override
  Override overrideWith(EpisodeList Function() create) {
    return ProviderOverride(
      origin: this,
      override: EpisodeListProvider._internal(
        () => create()..podcastId = podcastId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        podcastId: podcastId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EpisodeList, List<Episode>>
      createElement() {
    return _EpisodeListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EpisodeListProvider && other.podcastId == podcastId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, podcastId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EpisodeListRef on AutoDisposeAsyncNotifierProviderRef<List<Episode>> {
  /// The parameter `podcastId` of this provider.
  int get podcastId;
}

class _EpisodeListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EpisodeList, List<Episode>>
    with EpisodeListRef {
  _EpisodeListProviderElement(super.provider);

  @override
  int get podcastId => (origin as EpisodeListProvider).podcastId;
}

String _$historyEpisodesHash() => r'87c48663d01121c780ef6fe3c0ec8f707b2963e8';

/// Fetches all episodes from the history.
///
/// Copied from [HistoryEpisodes].
@ProviderFor(HistoryEpisodes)
final historyEpisodesProvider = AutoDisposeAsyncNotifierProvider<
    HistoryEpisodes, List<HistoryItem>>.internal(
  HistoryEpisodes.new,
  name: r'historyEpisodesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$historyEpisodesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HistoryEpisodes = AutoDisposeAsyncNotifier<List<HistoryItem>>;
String _$favoritedEpisodesHash() => r'219b35cda0ea4ddb56df2abd8fc67b6c58ca0b3c';

/// Fetches all favorited episodes from the database.
///
/// Copied from [FavoritedEpisodes].
@ProviderFor(FavoritedEpisodes)
final favoritedEpisodesProvider =
    AutoDisposeAsyncNotifierProvider<FavoritedEpisodes, List<Episode>>.internal(
  FavoritedEpisodes.new,
  name: r'favoritedEpisodesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritedEpisodesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavoritedEpisodes = AutoDisposeAsyncNotifier<List<Episode>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
