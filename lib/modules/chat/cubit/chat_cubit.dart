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

  Future<FollowupQuestion> onGoalCreated({
    required List<Message> messages,
  }) async {
   emit(state.copyWith(loading: true));
    print('state.loadingggggggggggggg');
    print(state.loading);
    final res = await _repo.createCredentials(messages: messages);

    final Map<String, dynamic> data = jsonDecode(res['message']['content']);
    final temp = FollowupQuestion.fromMap(data);
    // print('temppppppppppppppppppp');
    // print(temp);
    messages.add(Message.ai(content: temp.label));
    final tempp = [...messages];
    emit(state.copyWith(loading: false, messages: messages));
    print('state.loading');
    print(state.loading);
    print(state.messages);
    return temp;
  }
}
