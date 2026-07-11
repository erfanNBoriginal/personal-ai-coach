class Message {
  final String role;
  final String content;
  Message({required this.role, required this.content});

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      content: map['content'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap(Message message) {
    return {'role': role, 'content': content};
  }

  Message.ai({required this.content}) : role = 'assistant';
  Message.user({required this.content}) : role = 'user';
}
