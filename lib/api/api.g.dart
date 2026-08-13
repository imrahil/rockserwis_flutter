// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apiRepository)
final apiRepositoryProvider = ApiRepositoryProvider._();

final class ApiRepositoryProvider
    extends $FunctionalProvider<ApiRepository, ApiRepository, ApiRepository>
    with $Provider<ApiRepository> {
  ApiRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiRepositoryHash();

  @$internal
  @override
  $ProviderElement<ApiRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiRepository create(Ref ref) {
    return apiRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiRepository>(value),
    );
  }
}

String _$apiRepositoryHash() => r'7a55d7fd38af93d3aa5e1ae014d12a5bae30d864';
