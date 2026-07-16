part of 'task_cubit.dart';

class TaskState {
  final bool loading;
  final DayTask? task;
  TaskState({required this.loading, this.task});
  TaskState.init() : loading = false, task = null;

  TaskState copyWith({bool? loading, DayTask? task}) {
    return TaskState(loading: loading ?? this.loading, task: task ?? this.task);
  }
}
