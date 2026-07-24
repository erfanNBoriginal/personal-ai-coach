part of 'schedule_cubit.dart';

class ScheduleState {
  final bool loading;
  final List<SpecificTasks> dailyTasks;
  final String selectedDayIndex;
  ScheduleState({
    required this.loading,
    required this.dailyTasks,
    required this.selectedDayIndex,
  });

  ScheduleState.init(this.dailyTasks)
    : loading = false,
      selectedDayIndex = '';

  ScheduleState copyWith({
    bool? loading,
    List<SpecificTasks>? dailyTasks,
    String? selectedDayIndex,
  }) {
    return ScheduleState(
      loading: loading ?? this.loading,
      dailyTasks: dailyTasks ?? this.dailyTasks,
      selectedDayIndex: selectedDayIndex ?? this.selectedDayIndex,
    );
  }
}
