import 'dart:async'; // Add this import for StreamSubscription
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class TestWebSocketScreen extends ConsumerStatefulWidget {
  const TestWebSocketScreen({super.key});

  @override
  ConsumerState<TestWebSocketScreen> createState() => _TestWebSocketScreenState();
}

class _TestWebSocketScreenState extends ConsumerState<TestWebSocketScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _receiverController = TextEditingController();
  final List<String> _logs = [];
  StreamSubscription<Map<String, dynamic>>? _messageSubscription;

  @override
  void initState() {
    super.initState();
    // Start listening to messages when screen loads
    _startListening();
  }

  @override
  void dispose() {
    // Cancel subscription when screen is disposed
    _messageSubscription?.cancel();
    _messageController.dispose();
    _receiverController.dispose();
    super.dispose();
  }

  void _startListening() {
    try {
      // Get the message stream from notifier - FIXED provider name
      final stream = ref.read(webSocketProvider.notifier).getMessageStream();

      // Listen to incoming messages with explicit types
      _messageSubscription = stream.listen(
            (Map<String, dynamic> message) {
          _addLog('📥 Received message: $message');
        },
        onError: (Object error) {
          _addLog('❌ Stream error: $error');
        },
      );

      _addLog('👂 Listening for messages...');
    } catch (e) {
      _addLog('❌ Failed to start listening: $e');
    }
  }

  void _addLog(String message) {
    debugPrint(message); // Use debugPrint instead of print
    setState(() {
      _logs.add('${DateTime.now().toIso8601String().substring(11, 19)}: $message');
    });
  }

  void _clearLogs() {
    setState(() {
      _logs.clear();
    });
  }

  Future<void> _testConnection() async {
    final authState = ref.read(authProvider);
    final token = authState.user?.token;
    final username = authState.user?.username;

    if (token == null) {
      _addLog('❌ No token found. Login first.');
      return;
    }

    if (username == null) {
      _addLog('❌ No username found.');
      return;
    }

    try {
      _addLog('🔌 Connecting WebSocket...');

      // Get the notifier and call connect - FIXED provider name
      final notifier = ref.read(webSocketProvider.notifier);
      await notifier.connect(token);

      _addLog('✅ WebSocket connected!');

      // Subscribe to messages AFTER connection
      notifier.subscribeToPublicMessages();
      _addLog('📡 Subscribed to public messages');

      notifier.subscribeToPrivateMessages(username);
      _addLog('📡 Subscribed to private messages for $username');

    } catch (e) {
      _addLog('❌ Connection failed: $e');
    }
  }

  void _sendTestMessage() {
    final content = _messageController.text.trim();
    if (content.isEmpty) {
      _addLog('⚠️ Message is empty');
      return;
    }

    final authState = ref.read(authProvider);
    final sender = authState.user?.username;

    if (sender == null) {
      _addLog('❌ No user logged in');
      return;
    }

    try {
      final notifier = ref.read(webSocketProvider.notifier);
      notifier.sendPublicMessage(content, sender);

      _addLog('📤 Sent public message: "$content" from $sender');
      _messageController.clear();
    } catch (e) {
      _addLog('❌ Failed to send message: $e');
    }
  }

  void _sendPrivateMessage() {
    final content = _messageController.text.trim();
    final receiver = _receiverController.text.trim();

    if (content.isEmpty) {
      _addLog('⚠️ Message is empty');
      return;
    }

    if (receiver.isEmpty) {
      _addLog('⚠️ Receiver is empty');
      return;
    }

    final authState = ref.read(authProvider);
    final sender = authState.user?.username;

    if (sender == null) {
      _addLog('❌ No user logged in');
      return;
    }

    try {
      final notifier = ref.read(webSocketProvider.notifier);
      notifier.sendPrivateMessage(
        content: content,
        sender: sender,
        receiver: receiver,
      );

      _addLog('📤 Sent private message to $receiver: "$content"');
      _messageController.clear();
      _receiverController.clear();
    } catch (e) {
      _addLog('❌ Failed to send private message: $e');
    }
  }

  void _disconnect() {
    try {
      final notifier = ref.read(webSocketProvider.notifier);
      notifier.disconnect();
      _addLog('🔌 Disconnected');
    } catch (e) {
      _addLog('❌ Error during disconnect: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final webSocketState = ref.watch(webSocketProvider);
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Test'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _clearLogs,
          ),
        ],
      ),
      body: Column(
        children: [
          // Status panel
          Container(
            padding: const EdgeInsets.all(16),
            color: webSocketState.isConnected ? Colors.green.shade50 : Colors.red.shade50,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      webSocketState.isConnected ? Icons.check_circle : Icons.error,
                      color: webSocketState.isConnected ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      webSocketState.isConnected ? 'CONNECTED' : 'DISCONNECTED',
                      style: TextStyle(
                        color: webSocketState.isConnected ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('User: ${authState.user?.username ?? "Not logged in"}'),
                const SizedBox(height: 8),
                if (webSocketState.isLoading)
                  const Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 8),
                      Text('Connecting...'),
                    ],
                  ),
                if (webSocketState.error != null)
                  Text(
                    'Error: ${webSocketState.error!}',
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),

          // Controls
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _testConnection,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Connect', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _disconnect,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Disconnect', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Message input
                TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your message...',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.message),
                  ),
                  onSubmitted: (_) => _sendTestMessage(),
                ),
                const SizedBox(height: 12),

                // Receiver input for private messages
                TextField(
                  controller: _receiverController,
                  decoration: const InputDecoration(
                    hintText: 'Receiver username (for private)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _sendTestMessage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Send Public', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _sendPrivateMessage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('Send Private', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Logs header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Connection Logs',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Count: ${_logs.length}'),
              ],
            ),
          ),

          // Logs
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Colors.grey.shade50,
              child: ListView.builder(
                reverse: true, // Newest at top
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  final log = _logs.reversed.toList()[index];
                  final bool isError = log.contains('❌');
                  final bool isSuccess = log.contains('✅');
                  final bool isReceived = log.contains('📥');
                  final bool isSent = log.contains('📤');
                  final bool isWarning = log.contains('⚠️');

                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isError ? Colors.red.shade100 :
                        isSuccess ? Colors.green.shade100 :
                        isReceived ? Colors.blue.shade100 :
                        isSent ? Colors.yellow.shade100 :
                        isWarning ? Colors.orange.shade100 :
                        Colors.grey.shade100,
                      ),
                    ),
                    child: Text(
                      log,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: isError ? Colors.red :
                        isSuccess ? Colors.green :
                        isReceived ? Colors.blue :
                        isSent ? Colors.orange :
                        isWarning ? Colors.orange :
                        Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}