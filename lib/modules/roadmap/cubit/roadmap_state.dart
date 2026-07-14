part of 'roadmap_cubit.dart';

class RoadmapState {
  final bool loading;
  final Roadmap? roadmap;
  RoadmapState({required this.roadmap, required this.loading});

  RoadmapState.init() : roadmap = null, loading = false;

  RoadmapState copyWith({Roadmap? roadmap, bool? loading}) {
    return RoadmapState(
      roadmap: roadmap ?? this.roadmap,
      loading: loading ?? this.loading,
    );
  }
}
