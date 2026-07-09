class Message {
  final String role;
  final String content;
  Message({required this.role, required this.content});

  Message.ai({required this.content}) : role = 'assistant';
  Message.user({required this.content}) : role = 'user';
}
