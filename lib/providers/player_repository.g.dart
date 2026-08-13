// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PlayerRepository)
final playerRepositoryProvider = PlayerRepositoryProvider._();

final class PlayerRepositoryProvider
    extends $NotifierProvider<PlayerRepository, EpisodePlayerState> {
  PlayerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'playerRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$playerRepositoryHash();

  @$internal
  @override
  PlayerRepository create() => PlayerRepository();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EpisodePlayerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EpisodePlayerState>(value),
    );
  }
}

String _$playerRepositoryHash() => r'fb41754952903a803934fdebc812c310a770ea88';

abstract class _$PlayerRepository extends $Notifier<EpisodePlayerState> {
  EpisodePlayerState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<EpisodePlayerState, EpisodePlayerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EpisodePlayerState, EpisodePlayerState>,
              EpisodePlayerState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
