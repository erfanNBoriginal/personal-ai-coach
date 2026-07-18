part of 'schedule_cubit.dart';

class ScheduleState {
  final bool loading;
  final List<SpecificTasks> dailyTasks;
  final int selectedDayIndex;
  ScheduleState({
    required this.loading,
    required this.dailyTasks,
    required this.selectedDayIndex,
  });

  ScheduleState.init() : loading = false, dailyTasks = [], selectedDayIndex = 0;

  ScheduleState copyWith({
    bool? loading,
    List<SpecificTasks>? dailyTasks,
    int? selectedDayIndex,
  }) {
    return ScheduleState(
      loading: loading ?? this.loading,
      dailyTasks: dailyTasks ?? this.dailyTasks,
      selectedDayIndex: selectedDayIndex ?? this.selectedDayIndex,
    );
  }
}
