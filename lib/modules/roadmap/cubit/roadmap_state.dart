part of 'roadmap_cubit.dart';

class RoadmapState {
  final Roadmap? roadmap;
  RoadmapState({required this.roadmap});

  RoadmapState.init(): roadmap = null ;

  RoadmapState copyWith({Roadmap? roadmap}) {
    return RoadmapState(roadmap: roadmap ?? this.roadmap);
  }
}
