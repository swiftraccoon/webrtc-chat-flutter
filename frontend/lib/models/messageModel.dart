class Message {
  final String id;
  final String chatId;
  final String senderId;
  final String content;

  Message({required this.id, required this.chatId, required this.senderId, required this.content});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      chatId: json['chatId'],
      senderId: json['senderId'],
      content: json['content'],
    );
  }
}
