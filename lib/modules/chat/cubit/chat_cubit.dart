import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:personal_ai_coach/domains/business_repository/business_repository.dart';
import 'package:personal_ai_coach/domains/business_repository/models/followup_question.dart';
import 'package:personal_ai_coach/domains/business_repository/models/goal.dart';
import 'package:personal_ai_coach/domains/business_repository/models/message.dart';
import 'package:personal_ai_coach/domains/business_repository/models/roadmap.dart';
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
    // print('heyyyy');
    emit(state.copyWith(loading: true));
    final messagesList = [...state.messages];
    messagesList.add(message);
    final res = await _repo.createCredentials(messages: messagesList);
    final Map<String, dynamic> questionJson = jsonDecode(
      res['message']['content'],
    );
    final lastMessage = Message.fromMap(res['message']);
    final lastQuestion = FollowupQuestion.fromMap(questionJson);
    messagesList.add(lastMessage);
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

  void onAnswerSelected(Question question) {
    List<Question> list = [...state.selectedQuestions];
    list.add(question);
    emit(state.copyWith(selectedQuestions: list));
  }

  Future<Roadmap> onRoadmapGenrated() async {
    emit(state.copyWith(loading: true));
    Map<String, String> roadmapMap = {};
    roadmapMap = {'user goal': '${state.goal}'};
    for (var e = 0; e <= state.selectedQuestions.length - 1; e++) {
      roadmapMap.addEntries(
        <String, String>{
          state.selectedQuestions[e].questionLabel:
              state.selectedQuestions[e].label,
        }.entries,
      );
    }
    print('roadmappppppppppppppp');
    print(roadmapMap.toString());
    final res = await _repo.createRoadmap(
      message: Message.user(
        content:
            // roadmapMap.toString()
            '{user goal: i want to be a flutter developer, experience_level: Absolute beginner (no coding experience), time_commitment: 6-15 hours per week, goal_timeline: 12 months (Slow & steady), lifestyle_constraints: Fixed work/study hours (mostly weekends/evenings)}',
      ),
    );
    final Map<String, dynamic> roadmapJson = jsonDecode(
      res['message']['content'],
    );
    final roadmap = Roadmap.fromMap(roadmapJson);
    print('roadmap.milestones.lengthtttttttttttttttttt');
    emit(state.copyWith(loading: false));
    return roadmap;
  }
}
