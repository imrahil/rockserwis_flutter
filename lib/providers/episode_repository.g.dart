// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$episodeRepositoryHash() => r'ee90ae0b41c357aca8aa0f4f456d16bd2b09124d';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EpisodeRepositoryRef = AutoDisposeProviderRef<EpisodeRepository>;
String _$fetchEpisodesHash() => r'e97576f984cd9893d2bceb7ea556d333e89c13f3';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
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

String _$episodeListHash() => r'bbb7f8d3dd619bd99f223b950ea34a5e9a4dbc44';

/// See also [episodeList].
@ProviderFor(episodeList)
const episodeListProvider = EpisodeListFamily();

/// See also [episodeList].
class EpisodeListFamily extends Family<AsyncValue<List<Episode>>> {
  /// See also [episodeList].
  const EpisodeListFamily();

  /// See also [episodeList].
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

/// See also [episodeList].
class EpisodeListProvider extends AutoDisposeFutureProvider<List<Episode>> {
  /// See also [episodeList].
  EpisodeListProvider(
    int podcastId,
  ) : this._internal(
          (ref) => episodeList(
            ref as EpisodeListRef,
            podcastId,
          ),
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
  Override overrideWith(
    FutureOr<List<Episode>> Function(EpisodeListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EpisodeListProvider._internal(
        (ref) => create(ref as EpisodeListRef),
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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EpisodeListRef on AutoDisposeFutureProviderRef<List<Episode>> {
  /// The parameter `podcastId` of this provider.
  int get podcastId;
}

class _EpisodeListProviderElement
    extends AutoDisposeFutureProviderElement<List<Episode>>
    with EpisodeListRef {
  _EpisodeListProviderElement(super.provider);

  @override
  int get podcastId => (origin as EpisodeListProvider).podcastId;
}

String _$historyEpisodesHash() => r'bd9b189838508fd0035d85419a8a0504aba97d86';

/// Fetches all episodes from the history.
///
/// Copied from [historyEpisodes].
@ProviderFor(historyEpisodes)
final historyEpisodesProvider =
    AutoDisposeFutureProvider<List<Episode>>.internal(
  historyEpisodes,
  name: r'historyEpisodesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$historyEpisodesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HistoryEpisodesRef = AutoDisposeFutureProviderRef<List<Episode>>;
String _$favoritedEpisodesHash() => r'b90ebb2495f9af5d79495972f2a654a49254ac84';

/// Fetches all favorited episodes from the database.
///
/// Copied from [favoritedEpisodes].
@ProviderFor(favoritedEpisodes)
final favoritedEpisodesProvider =
    AutoDisposeFutureProvider<List<Episode>>.internal(
  favoritedEpisodes,
  name: r'favoritedEpisodesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoritedEpisodesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoritedEpisodesRef = AutoDisposeFutureProviderRef<List<Episode>>;
String _$watchFavoritedEpisodeHash() =>
    r'83ac593413671d32d28c030686c12634a5166fb7';

/// See also [watchFavoritedEpisode].
@ProviderFor(watchFavoritedEpisode)
const watchFavoritedEpisodeProvider = WatchFavoritedEpisodeFamily();

/// See also [watchFavoritedEpisode].
class WatchFavoritedEpisodeFamily extends Family<AsyncValue<bool>> {
  /// See also [watchFavoritedEpisode].
  const WatchFavoritedEpisodeFamily();

  /// See also [watchFavoritedEpisode].
  WatchFavoritedEpisodeProvider call(
    int episodeId,
  ) {
    return WatchFavoritedEpisodeProvider(
      episodeId,
    );
  }

  @override
  WatchFavoritedEpisodeProvider getProviderOverride(
    covariant WatchFavoritedEpisodeProvider provider,
  ) {
    return call(
      provider.episodeId,
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
  String? get name => r'watchFavoritedEpisodeProvider';
}

/// See also [watchFavoritedEpisode].
class WatchFavoritedEpisodeProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [watchFavoritedEpisode].
  WatchFavoritedEpisodeProvider(
    int episodeId,
  ) : this._internal(
          (ref) => watchFavoritedEpisode(
            ref as WatchFavoritedEpisodeRef,
            episodeId,
          ),
          from: watchFavoritedEpisodeProvider,
          name: r'watchFavoritedEpisodeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchFavoritedEpisodeHash,
          dependencies: WatchFavoritedEpisodeFamily._dependencies,
          allTransitiveDependencies:
              WatchFavoritedEpisodeFamily._allTransitiveDependencies,
          episodeId: episodeId,
        );

  WatchFavoritedEpisodeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.episodeId,
  }) : super.internal();

  final int episodeId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(WatchFavoritedEpisodeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchFavoritedEpisodeProvider._internal(
        (ref) => create(ref as WatchFavoritedEpisodeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        episodeId: episodeId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _WatchFavoritedEpisodeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchFavoritedEpisodeProvider &&
        other.episodeId == episodeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, episodeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WatchFavoritedEpisodeRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `episodeId` of this provider.
  int get episodeId;
}

class _WatchFavoritedEpisodeProviderElement
    extends AutoDisposeFutureProviderElement<bool>
    with WatchFavoritedEpisodeRef {
  _WatchFavoritedEpisodeProviderElement(super.provider);

  @override
  int get episodeId => (origin as WatchFavoritedEpisodeProvider).episodeId;
}

String _$allEpisodesHash() => r'bfdb52a89188298cb08b87def060325d13cf4e49';

/// See also [AllEpisodes].
@ProviderFor(AllEpisodes)
final allEpisodesProvider =
    AsyncNotifierProvider<AllEpisodes, List<Episode>>.internal(
  AllEpisodes.new,
  name: r'allEpisodesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allEpisodesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AllEpisodes = AsyncNotifier<List<Episode>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
