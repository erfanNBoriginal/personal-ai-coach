part of 'chat_cubit.dart';

class ChatState {
  final bool loading;
  final Goal? goal;

  ChatState({required this.loading, this.goal});

  ChatState.init() : loading = false, goal = null;

  ChatState copyWith({bool? loading, Goal? goal}) {
    return ChatState(loading: loading ?? this.loading, goal: goal ?? this.goal);
  }
}
