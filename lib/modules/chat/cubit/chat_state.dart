part of 'chat_cubit.dart';

class ChatState {
  final String? chatId;
  final bool loading;
  final String? goal;
  final List<Message> messages;
  final List<FollowupQuestion> questions;

  ChatState({
    required this.loading,
    this.goal,
    required this.messages,
    required this.questions,
    this.chatId,
  });

  ChatState.init()
    : loading = false,
      goal = null,
      messages = [],
      questions = [],
      chatId = const Uuid().v4();

  ChatState copyWith({
    bool? loading,
    String? goal,
    List<Message>? messages,
    List<FollowupQuestion>? questions,
  }) {
    return ChatState(
      loading: loading ?? this.loading,
      goal: goal ?? this.goal,
      questions: questions ?? this.questions,
      messages: messages ?? this.messages,
    );
  }
}
