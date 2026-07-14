import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:personal_ai_coach/domains/business_repository/models/roadmap.dart';

part 'roadmap_state.dart';

class RoadmapCubit extends Cubit<RoadmapState> {
  RoadmapCubit() : super(RoadmapState.init());
}
