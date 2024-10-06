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

String _$fetchFavoritedEpisodesHash() =>
    r'80e54c558698208846189b6b6f88e9a504a6adec';

/// See also [fetchFavoritedEpisodes].
@ProviderFor(fetchFavoritedEpisodes)
final fetchFavoritedEpisodesProvider =
    AutoDisposeFutureProvider<List<Episode>>.internal(
  fetchFavoritedEpisodes,
  name: r'fetchFavoritedEpisodesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchFavoritedEpisodesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchFavoritedEpisodesRef = AutoDisposeFutureProviderRef<List<Episode>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
