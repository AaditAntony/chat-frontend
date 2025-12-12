// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_socket_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(webSocketService)
const webSocketServiceProvider = WebSocketServiceProvider._();

final class WebSocketServiceProvider extends $FunctionalProvider<
    WebSocketService,
    WebSocketService,
    WebSocketService> with $Provider<WebSocketService> {
  const WebSocketServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'webSocketServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$webSocketServiceHash();

  @$internal
  @override
  $ProviderElement<WebSocketService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WebSocketService create(Ref ref) {
    return webSocketService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSocketService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSocketService>(value),
    );
  }
}

String _$webSocketServiceHash() => r'd2367ec5da91f972e65159407bfa1bc6fd3b1054';

@ProviderFor(WebSocketNotifier)
const webSocketProvider = WebSocketNotifierProvider._();

final class WebSocketNotifierProvider
    extends $NotifierProvider<WebSocketNotifier, WebSocketState> {
  const WebSocketNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'webSocketProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$webSocketNotifierHash();

  @$internal
  @override
  WebSocketNotifier create() => WebSocketNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSocketState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSocketState>(value),
    );
  }
}

String _$webSocketNotifierHash() => r'58c372254394aad6fa457202fe919e4844b64b8a';

abstract class _$WebSocketNotifier extends $Notifier<WebSocketState> {
  WebSocketState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WebSocketState, WebSocketState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<WebSocketState, WebSocketState>,
        WebSocketState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
