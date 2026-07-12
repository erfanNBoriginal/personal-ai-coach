part of 'chat_cubit.dart';

class ChatState {
  final String? chatId;
  final bool loading;
  final String? goal;
  final List<Message> messages;
  final List<FollowupQuestion> questions;
  final List<Question> selectedQuestions;

  ChatState({
    required this.loading,
    required this.messages,
    required this.questions,
    required this.selectedQuestions,
    this.chatId,
    this.goal,
  });

  ChatState.init()
    : loading = false,
      goal = null,
      messages = [],
      questions = [],
      selectedQuestions = [],
      chatId = const Uuid().v4();

  ChatState copyWith({
    bool? loading,
    String? goal,
    List<Message>? messages,
    List<FollowupQuestion>? questions,
    List<Question>? selectedQuestions,
  }) {
    return ChatState(
      loading: loading ?? this.loading,
      goal: goal ?? this.goal,
      questions: questions ?? this.questions,
      messages: messages ?? this.messages,
      selectedQuestions: selectedQuestions ?? this.selectedQuestions,
    );
  }
}
