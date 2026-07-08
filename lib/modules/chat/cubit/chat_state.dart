part of 'chat_cubit.dart';

class ChatState {
  final bool loading;

  ChatState({required this.loading});

  ChatState.init() : loading = false;

  ChatState copyWith({bool? loading}) {
    return ChatState(loading: loading ?? this.loading);
  }
}
