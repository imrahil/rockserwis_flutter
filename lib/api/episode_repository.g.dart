// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$episodeRepositoryHash() => r'74339ee057f2e2786f09aad03d1af498cdf8c225';

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
String _$fetchEpisodesHash() => r'0bb566155f9793fd07e47e16744eb89b54959a73';

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
    Podcast currentPodcast,
  ) {
    return FetchEpisodesProvider(
      currentPodcast,
    );
  }

  @override
  FetchEpisodesProvider getProviderOverride(
    covariant FetchEpisodesProvider provider,
  ) {
    return call(
      provider.currentPodcast,
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
    Podcast currentPodcast,
  ) : this._internal(
          (ref) => fetchEpisodes(
            ref as FetchEpisodesRef,
            currentPodcast,
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
          currentPodcast: currentPodcast,
        );

  FetchEpisodesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.currentPodcast,
  }) : super.internal();

  final Podcast currentPodcast;

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
        currentPodcast: currentPodcast,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Episode>> createElement() {
    return _FetchEpisodesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchEpisodesProvider &&
        other.currentPodcast == currentPodcast;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, currentPodcast.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchEpisodesRef on AutoDisposeFutureProviderRef<List<Episode>> {
  /// The parameter `currentPodcast` of this provider.
  Podcast get currentPodcast;
}

class _FetchEpisodesProviderElement
    extends AutoDisposeFutureProviderElement<List<Episode>>
    with FetchEpisodesRef {
  _FetchEpisodesProviderElement(super.provider);

  @override
  Podcast get currentPodcast =>
      (origin as FetchEpisodesProvider).currentPodcast;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
