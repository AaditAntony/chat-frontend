import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:dio/dio.dart';
import '../constants/app_constants.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  String? _token;
  final Dio _dio;

  WebSocketService(this._dio);

  // Initialize WebSocket connection
  Future<void> connect(String token) async {
    _token = token;

    try {
      final wsUrl = AppConstants.wsUrl;

      // Create WebSocket connection with authentication header
      _channel = IOWebSocketChannel.connect(
        wsUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Origin': 'http://localhost',
        },
      );

      print('🔌 WebSocket connected to: $wsUrl');

      // Send connection confirmation
      _channel?.sink.add('CONNECTED');

    } catch (e) {
      print('❌ WebSocket connection failed: $e');
      rethrow;
    }
  }

  // Send public message
  void sendPublicMessage(String content, String sender) {
    final message = {
      'sender': sender,
      'content': content,
      'type': 'PUBLIC',
    };

    _channel?.sink.add('SEND:/app/chat.send\n${_formatMessage(message)}');
  }

  // Send private message
  void sendPrivateMessage({
    required String content,
    required String sender,
    required String receiver,
  }) {
    final message = {
      'sender': sender,
      'receiver': receiver,
      'content': content,
      'type': 'PRIVATE',
      'timestamp': DateTime.now().toIso8601String(),
    };

    _channel?.sink.add('SEND:/app/private.send\n${_formatMessage(message)}');
  }

  // Subscribe to public messages
  void subscribeToPublicMessages() {
    _channel?.sink.add('SUBSCRIBE:/topic/global\nid:sub-${DateTime.now().millisecondsSinceEpoch}');
  }

  // Subscribe to private messages for a user
  void subscribeToPrivateMessages(String username) {
    _channel?.sink.add('SUBSCRIBE:/topic/private.$username\nid:sub-private-$username');
  }

  // Listen to incoming messages
  Stream<dynamic> get messageStream {
    return _channel?.stream ?? const Stream.empty();
  }

  // Format message for STOMP protocol
  String _formatMessage(Map<String, dynamic> message) {
    final body = '${message.entries.map((e) => '"${e.key}":"${e.value}"').join(',')}';
    return 'content-type:application/json\n\n{$body}\u0000';
  }

  // Disconnect WebSocket
  void disconnect() {
    _channel?.sink.close();
    _channel = null;
    print('🔌 WebSocket disconnected');
  }

  // Check if connected
  bool get isConnected => _channel != null;
}