part of 'roadmap_cubit.dart';

class RoadmapState {
  final bool loading;
  final String? goal;
  final Roadmap? roadmap;
  final WeeklyTasks? weeklyTasks;
  RoadmapState({
    required this.roadmap,
    required this.loading,
    this.goal,
    this.weeklyTasks,
  });

  RoadmapState.init()
    : roadmap = null,
      goal = '',
      loading = false,
      weeklyTasks = null;

  RoadmapState copyWith({
    Roadmap? roadmap,
    String? goal,
    bool? loading,
    WeeklyTasks? weeklyTasks,
  }) {
    return RoadmapState(
      roadmap: roadmap ?? this.roadmap,
      loading: loading ?? this.loading,
      goal: goal ?? this.goal,
      weeklyTasks: weeklyTasks ?? this.weeklyTasks,
    );
  }
}
