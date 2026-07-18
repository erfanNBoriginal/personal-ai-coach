part of 'schedule_cubit.dart';

class ScheduleState {
  final bool loading;
  final List<DayTask>? daylyTasks;
  ScheduleState({required this.loading, this.daylyTasks});

  ScheduleState.init() : loading = false, daylyTasks = [];

  ScheduleState copyWith({bool? loading, List<DayTask>? daylyTasks}) {
    return ScheduleState(
      loading: loading ?? this.loading,
      daylyTasks: daylyTasks ?? this.daylyTasks,
    );
  }
}
