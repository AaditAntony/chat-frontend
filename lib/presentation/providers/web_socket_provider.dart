import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/web_socket_service.dart';
import 'auth_provider.dart';

part 'web_socket_provider.g.dart';

// Provider for WebSocketService
@riverpod
WebSocketService webSocketService(Ref ref) {
  return WebSocketService();
}

// State for WebSocket connection
class WebSocketState {
  final bool isConnected;
  final bool isLoading;
  final String? error;

  WebSocketState({
    this.isConnected = false,
    this.isLoading = false,
    this.error,
  });

  WebSocketState copyWith({
    bool? isConnected,
    bool? isLoading,
    String? error,
  }) {
    return WebSocketState(
      isConnected: isConnected ?? this.isConnected,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Notifier for WebSocket state management
@riverpod
class WebSocketNotifier extends _$WebSocketNotifier {
  @override
  WebSocketState build() {
    return WebSocketState();
  }

  // Connect to WebSocket
  // In web_socket_provider.dart, update the connect method:
  Future<void> connect(String token) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final webSocketService = ref.read(webSocketServiceProvider);
      await webSocketService.connect(token);

      // Get username from auth state
      final authState = ref.read(authProvider);
      final username = authState.user?.username;

      if (username != null) {
        // Subscribe to messages after connection
        webSocketService.subscribeToPublicMessages();
        webSocketService.subscribeToPrivateMessages(username);
      }

      state = state.copyWith(
        isConnected: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
      rethrow;
    }
  }

  // Disconnect WebSocket
  Future<void> disconnect() async {
    try {
      final webSocketService = ref.read(webSocketServiceProvider);
      webSocketService.disconnect();

      state = WebSocketState();
    } catch (e) {
      // Silently handle disconnect errors
    }
  }

  // Send public message
  void sendPublicMessage(String content, String sender) {
    try {
      final webSocketService = ref.read(webSocketServiceProvider);
      webSocketService.sendPublicMessage(content, sender);
    } catch (e) {
      // Silently handle send errors
    }
  }

  // Send private message
  void sendPrivateMessage({
    required String content,
    required String sender,
    required String receiver,
  }) {
    try {
      final webSocketService = ref.read(webSocketServiceProvider);
      webSocketService.sendPrivateMessage(
        content: content,
        sender: sender,
        receiver: receiver,
      );
    } catch (e) {
      // Silently handle send errors
    }
  }

  // Subscribe to public messages
  void subscribeToPublicMessages() {
    try {
      final webSocketService = ref.read(webSocketServiceProvider);
      webSocketService.subscribeToPublicMessages();
    } catch (e) {
      // Silently handle subscription errors
    }
  }

  // Subscribe to private messages
  void subscribeToPrivateMessages(String username) {
    try {
      final webSocketService = ref.read(webSocketServiceProvider);
      webSocketService.subscribeToPrivateMessages(username);
    } catch (e) {
      // Silently handle subscription errors
    }
  }

  // Get message stream
  Stream<Map<String, dynamic>> getMessageStream() {
    try {
      final webSocketService = ref.read(webSocketServiceProvider);
      return webSocketService.messageStream;
    } catch (e) {
      return const Stream.empty();
    }
  }
}