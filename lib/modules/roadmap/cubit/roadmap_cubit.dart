import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:personal_ai_coach/domains/business_repository/models/roadmap.dart';

part 'roadmap_state.dart';

class RoadmapCubit extends Cubit<RoadmapState> {
  final Roadmap? initialRoadmap;

  RoadmapCubit({this.initialRoadmap}) : super(RoadmapState.init()) {
    onInit();
  }

  void onInit() {
    emit(state.copyWith(roadmap: initialRoadmap));
  }
}
