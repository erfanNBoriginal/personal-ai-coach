import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:personal_ai_coach/domains/business_repository/business_repository.dart';
import 'package:personal_ai_coach/domains/business_repository/models/followup_question.dart';
import 'package:personal_ai_coach/domains/business_repository/models/goal.dart';
import 'package:personal_ai_coach/domains/business_repository/models/message.dart';
import 'package:uuid/uuid.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final BusinessRepository _repo;
  final goalCtrl = TextEditingController();

  ChatCubit({required BusinessRepository repository})
    : _repo = repository,
      super(ChatState.init());

  Future<void> onInit() async {}

  Future<void> onGoalCreated({required Message message}) async {
    emit(state.copyWith(loading: true));
    final res = await _repo.createCredentials(message: message);
    final Map<String, dynamic> questionJson = jsonDecode(
      res['message']['content'],
    );
    final lastMessage = Message.fromMap(res['message']);
    final messagesList = [message, ...state.messages, lastMessage];
    final lastQuestion = FollowupQuestion.fromMap(questionJson);
    final questionsList = [...state.questions, lastQuestion];
    emit(
      state.copyWith(
        loading: false,
        questions: questionsList,
        goal: goalCtrl.text,
        messages: messagesList,
      ),
    );
  }
}
