class MessageModel {
  final String sender;
  final String content;
  final DateTime timestamp;

  MessageModel({
    required this.sender,
    required this.content,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      sender: json['sender'] as String? ?? 'Unknown',
      content: json['content'] as String? ?? '',
      timestamp: DateTime.parse(json['timestamp'] as String? ?? DateTime.now().toIso8601String()),
    );
  }
}