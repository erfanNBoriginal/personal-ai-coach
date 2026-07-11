part of 'chat_cubit.dart';

class ChatState {
  final String? chatId;
  final bool loading;
  final Goal? goal;
  final List<Message>? messages;

  ChatState({required this.loading, this.goal, this.messages, this.chatId});

  ChatState.init()
    : loading = false,
      goal = null,
      messages = [],
      chatId = const Uuid().v4();

  ChatState copyWith({bool? loading, Goal? goal, List<Message>? messages}) {
    return ChatState(
      loading: loading ?? this.loading,
      goal: goal ?? this.goal,
      messages: messages ?? this.messages,
    );
  }
}
