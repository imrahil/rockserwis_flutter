// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objectbox_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(objectBox)
final objectBoxProvider = ObjectBoxProvider._();

final class ObjectBoxProvider
    extends
        $FunctionalProvider<
          AsyncValue<ObjectBox>,
          ObjectBox,
          FutureOr<ObjectBox>
        >
    with $FutureModifier<ObjectBox>, $FutureProvider<ObjectBox> {
  ObjectBoxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'objectBoxProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$objectBoxHash();

  @$internal
  @override
  $FutureProviderElement<ObjectBox> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ObjectBox> create(Ref ref) {
    return objectBox(ref);
  }
}

String _$objectBoxHash() => r'e8a8cd717ae2d93c747598a2f7db6ac12677a2af';
