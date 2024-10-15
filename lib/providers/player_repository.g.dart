// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioHandlerHash() => r'fb78767e4c98d1a25f03dd79bca642bda11b2df1';

/// See also [audioHandler].
@ProviderFor(audioHandler)
final audioHandlerProvider = FutureProvider<MyAudioHandler>.internal(
  audioHandler,
  name: r'audioHandlerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$audioHandlerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AudioHandlerRef = FutureProviderRef<MyAudioHandler>;
String _$playerRepositoryHash() => r'b74f9da6fd5f0223899fafae3aa57a41b7b1d2f0';

/// See also [PlayerRepository].
@ProviderFor(PlayerRepository)
final playerRepositoryProvider =
    NotifierProvider<PlayerRepository, ProgressBarState>.internal(
  PlayerRepository.new,
  name: r'playerRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playerRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PlayerRepository = Notifier<ProgressBarState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
