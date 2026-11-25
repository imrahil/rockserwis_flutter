// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_library.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Connects the [MediaLibrary] (what Android Auto browses and plays) to the
/// audio handler.
///
/// Read this in main() before runApp: when Android Auto starts the app in
/// the background there is no activity and no UI, so nothing else would
/// initialise the audio service and answer Android Auto's requests.

@ProviderFor(mediaLibrary)
final mediaLibraryProvider = MediaLibraryProvider._();

/// Connects the [MediaLibrary] (what Android Auto browses and plays) to the
/// audio handler.
///
/// Read this in main() before runApp: when Android Auto starts the app in
/// the background there is no activity and no UI, so nothing else would
/// initialise the audio service and answer Android Auto's requests.

final class MediaLibraryProvider
    extends
        $FunctionalProvider<
          AsyncValue<MediaLibrary>,
          MediaLibrary,
          FutureOr<MediaLibrary>
        >
    with $FutureModifier<MediaLibrary>, $FutureProvider<MediaLibrary> {
  /// Connects the [MediaLibrary] (what Android Auto browses and plays) to the
  /// audio handler.
  ///
  /// Read this in main() before runApp: when Android Auto starts the app in
  /// the background there is no activity and no UI, so nothing else would
  /// initialise the audio service and answer Android Auto's requests.
  MediaLibraryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mediaLibraryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mediaLibraryHash();

  @$internal
  @override
  $FutureProviderElement<MediaLibrary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MediaLibrary> create(Ref ref) {
    return mediaLibrary(ref);
  }
}

String _$mediaLibraryHash() => r'd540c22eee0da7558c2845c8b9f78d102a9692b1';
