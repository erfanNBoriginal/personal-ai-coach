class Message {
  final String role;
  final String content;
  Message({required this.role, required this.content});

  Map<String, dynamic> toMap(Message message) {
    return {'role': role, 'content': content};
  }

  Message.ai({required this.content}) : role = 'assistant';
  Message.user({required this.content}) : role = 'user';
}
