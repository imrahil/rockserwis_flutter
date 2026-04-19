// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(audioService)
final audioServiceProvider = AudioServiceProvider._();

final class AudioServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<MyAudioHandler>,
          MyAudioHandler,
          FutureOr<MyAudioHandler>
        >
    with $FutureModifier<MyAudioHandler>, $FutureProvider<MyAudioHandler> {
  AudioServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioServiceHash();

  @$internal
  @override
  $FutureProviderElement<MyAudioHandler> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MyAudioHandler> create(Ref ref) {
    return audioService(ref);
  }
}

String _$audioServiceHash() => r'36ff69a5630fc76e4b7afdb7943881307821f913';
