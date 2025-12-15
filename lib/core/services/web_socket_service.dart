import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import '../constants/app_constants.dart';

class WebSocketService {
  WebSocketChannel? _channel;

  WebSocketService();

  // Initialize WebSocket connection
  Future<void> connect(String token) async {
    try {
      final wsUrl = AppConstants.wsUrl;
      print('🔄 Connecting to: $wsUrl');

      // Clean token
      String cleanToken = token;
      if (cleanToken.startsWith('Bearer ')) {
        cleanToken = cleanToken.substring(7);
      }

      // SIMPLE CONNECTION - Remove Uri.parse()
      _channel = IOWebSocketChannel.connect(
        wsUrl, // Use string directly, NOT Uri.parse()
        headers: {
          'Authorization': 'Bearer $cleanToken',
        },
      );

      print('✅ WebSocket channel created');

      // Listen for CONNECTED response
      _channel!.stream.listen(
            (message) {
          print('📥 RAW: $message');
          if (message.toString().contains('CONNECTED')) {
            print('🎉 STOMP Connected!');
          }
        },
        onError: (error) {
          print('❌ WebSocket error: $error');
        },
        onDone: () {
          print('🔌 Connection closed');
        },
      );

      // Send CONNECT frame
      _channel!.sink.add('CONNECT\naccept-version:1.2\n\n\x00');

    } catch (e) {
      print('❌ Connection failed: $e');
      rethrow;
    }
  }

  // Send STOMP frame helper
  void _sendStompFrame(String command, Map<String, String>? headers, String body) {
    final buffer = StringBuffer();
    buffer.write('$command\n');

    if (headers != null) {
      headers.forEach((key, value) {
        buffer.write('$key:$value\n');
      });
    }

    buffer.write('\n$body\u0000');
    _channel?.sink.add(buffer.toString());
  }

  // Send public message
  void sendPublicMessage(String content, String sender) {
    final headers = {
      'destination': '/app/chat.send',
      'content-type': 'application/json',
    };

    final body = jsonEncode({
      'sender': sender,
      'content': content,
    });

    _sendStompFrame('SEND', headers, body);
  }

  // Send private message
  void sendPrivateMessage({
    required String content,
    required String sender,
    required String receiver,
  }) {
    final headers = {
      'destination': '/app/private.send',
      'content-type': 'application/json',
    };

    final body = jsonEncode({
      'sender': sender,
      'receiver': receiver,
      'content': content,
      'timestamp': DateTime.now().toIso8601String(),
    });

    _sendStompFrame('SEND', headers, body);
  }

  // Subscribe to public messages
  void subscribeToPublicMessages() {
    final subscriptionId = 'sub-global-${DateTime.now().millisecondsSinceEpoch}';
    final headers = {
      'id': subscriptionId,
      'destination': '/topic/global',
    };

    _sendStompFrame('SUBSCRIBE', headers, '');
  }

  // Subscribe to private messages for a user
  void subscribeToPrivateMessages(String username) {
    final subscriptionId = 'sub-private-$username';
    final headers = {
      'id': subscriptionId,
      'destination': '/topic/private.$username',
    };

    _sendStompFrame('SUBSCRIBE', headers, '');
  }

  // Parse STOMP message
  Map<String, dynamic>? _parseStompMessage(String message) {
    try {
      final lines = message.split('\n');
      if (lines.length < 2) return null;

      final command = lines[0];
      if (command != 'MESSAGE') return null;

      // Find the empty line separating headers from body
      int bodyStartIndex = 1;
      while (bodyStartIndex < lines.length && lines[bodyStartIndex].isNotEmpty) {
        bodyStartIndex++;
      }

      // Extract body (skip the empty line)
      if (bodyStartIndex + 1 < lines.length) {
        final body = lines[bodyStartIndex + 1];
        if (body.isNotEmpty) {
          return jsonDecode(body) as Map<String, dynamic>;
        }
      }
    } catch (e) {
      // Silently catch parsing errors
    }
    return null;
  }

  // Listen to incoming messages
  Stream<Map<String, dynamic>> get messageStream {
    return _channel?.stream.asyncMap((message) {
      final parsed = _parseStompMessage(message.toString());
      if (parsed != null) {
        return parsed;
      }

      // Return empty map for non-message frames
      return <String, dynamic>{};
    }).where((message) => message.isNotEmpty) ?? const Stream.empty();
  }

  // Disconnect WebSocket
  void disconnect() {
    if (_channel != null) {
      // Send STOMP DISCONNECT frame
      _channel?.sink.add('DISCONNECT\n\n\u0000');

      // Close the connection
      _channel?.sink.close();
      _channel = null;
    }
  }

  // Check if connected
  bool get isConnected => _channel != null;
}