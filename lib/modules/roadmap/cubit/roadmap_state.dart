part of 'roadmap_cubit.dart';

class RoadmapState {
  final bool loading;
  final int count;
  final String? goal;
  final Roadmap? roadmap;
  final WeeklyTasks? weeklyTasks;
  RoadmapState({
    required this.loading,
    this.count = 0,
    required this.roadmap,
    this.goal,
    this.weeklyTasks,
  });

  RoadmapState.init()
    : roadmap = null,
      goal = '',
      loading = false,
      weeklyTasks = null,
      count = 0
      ;

  RoadmapState copyWith({
    Roadmap? roadmap,
    String? goal,
    bool? loading,
    WeeklyTasks? weeklyTasks,
    int? count,
  }) {
    return RoadmapState(
      roadmap: roadmap ?? this.roadmap,
      loading: loading ?? this.loading,
      goal: goal ?? this.goal,
      weeklyTasks: weeklyTasks ?? this.weeklyTasks,
      count: count ?? this.count,
    );
  }
}
