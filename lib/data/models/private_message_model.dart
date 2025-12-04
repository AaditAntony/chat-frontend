class PrivateMessageModel {
  final String sender;
  final String receiver;
  final String content;
  final DateTime timestamp;

  PrivateMessageModel({
    required this.sender,
    required this.receiver,
    required this.content,
    required this.timestamp,
  });

  factory PrivateMessageModel.fromJson(Map<String, dynamic> json) {
    return PrivateMessageModel(
      sender: json['sender'] as String? ?? '',
      receiver: json['receiver'] as String? ?? '',
      content: json['content'] as String? ?? '',
      timestamp: DateTime.parse(json['timestamp'] as String? ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}