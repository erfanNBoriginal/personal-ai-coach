import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:personal_ai_coach/domains/business_repository/models/task.dart';
import 'package:personal_ai_coach/domains/business_repository/models/weekly_tasks.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final List<SpecificTasks>? initialTasks;

  ScheduleCubit({this.initialTasks}) : super(ScheduleState.init()){
    onInit();
  }

  void onInit() {
    emit(state.copyWith(dailyTasks: initialTasks));
    print('state.dailyTasks');
    print(state.dailyTasks);
  }

  void selectDay(int index) {
    emit(state.copyWith(selectedDayIndex: index));
  }
}
