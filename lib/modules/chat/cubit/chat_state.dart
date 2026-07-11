part of 'chat_cubit.dart';

class ChatState {
  final String? chatId;
  final bool loading;
  final Goal? goal;
  final List<FollowupQuestion> messages;

  ChatState({
    required this.loading,
    this.goal,
    required this.messages,
    this.chatId,
  });

  ChatState.init()
    : loading = false,
      goal = null,
      messages = [],
      chatId = const Uuid().v4();

  ChatState copyWith({
    bool? loading,
    Goal? goal,
    List<FollowupQuestion>? messages,
  }) {
    return ChatState(
      loading: loading ?? this.loading,
      goal: goal ?? this.goal,
      messages: messages ?? this.messages,
    );
  }
}
