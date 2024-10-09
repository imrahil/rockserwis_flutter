// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_db_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$episodeListHash() => r'8a1dcf17c7159513f30ed1893dcf802ff824e9e1';

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

String _$favoritedEpisodesHash() => r'b019766cff16cb86d2fa5a612824e5cee7b617b3';

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