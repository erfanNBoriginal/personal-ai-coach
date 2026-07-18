import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:personal_ai_coach/domains/business_repository/models/task.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit() : super(ScheduleState.init());
}
