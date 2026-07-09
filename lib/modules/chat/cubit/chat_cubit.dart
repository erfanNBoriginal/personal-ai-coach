import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:personal_ai_coach/domains/business_repository/business_repository.dart';
import 'package:personal_ai_coach/domains/business_repository/models/goal.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final BusinessRepository _repo;
  final goalCtrl = TextEditingController();

  ChatCubit({required BusinessRepository repository})
    : _repo = repository,
      super(ChatState.init());

  Future<void> onGoalCreated() async {
    
  }
}
