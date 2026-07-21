import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:personal_ai_coach/domains/business_repository/models/weekly_tasks.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final List<SpecificTasks>? initialTasks;
  final ScrollController tabCtril = ScrollController();
  final PageController pageCtrl = PageController();

  ScheduleCubit({this.initialTasks}) : super(ScheduleState.init()) {
    onInit();
  }

  void onInit() {
    emit(state.copyWith(dailyTasks: initialTasks));
    print('state.dailyTasks');
    print(state.dailyTasks);
  }

  void selectDay(String day) {
    emit(state.copyWith(selectedDayIndex: day));
  }
}
