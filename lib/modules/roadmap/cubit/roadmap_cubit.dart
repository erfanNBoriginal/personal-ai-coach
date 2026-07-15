import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:personal_ai_coach/domains/business_repository/business_repository.dart';
import 'package:personal_ai_coach/domains/business_repository/models/message.dart';
import 'package:personal_ai_coach/domains/business_repository/models/roadmap.dart';
import 'package:personal_ai_coach/domains/business_repository/models/task.dart';

part 'roadmap_state.dart';

class RoadmapCubit extends Cubit<RoadmapState> {
  final BusinessRepository _repo;
  final Roadmap? initialRoadmap;
  final String? initialGoal;

  // ignore: prefer_initializing_formals
  RoadmapCubit({
    this.initialGoal,
    this.initialRoadmap,
    required BusinessRepository repo,
  }) : _repo = repo,
       super(RoadmapState.init()) {
    onInit();
  }

  Future<dynamic> onWeeklyTasksCreated(String message) async {
    emit(state.copyWith(loading: true));
    final res = await _repo.createWeeklyTasks(Message.user(content: message));
    final Map<String, dynamic> weekJson = jsonDecode(res['message']['content']);
    WeeklyTasks weeklyTasks = WeeklyTasks.fromMap(weekJson);
    emit(state.copyWith(loading: false, weeklyTasks: weeklyTasks));
  }

  void onInit() {
    emit(state.copyWith(roadmap: initialRoadmap, goal: initialGoal));
  }
}
