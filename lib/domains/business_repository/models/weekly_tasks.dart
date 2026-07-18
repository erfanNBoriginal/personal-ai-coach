import 'package:personal_ai_coach/domains/business_repository/models/task.dart';

class SpecificTasks {
  final String day;
  final List<DayTask> tasks;
  SpecificTasks({required this.day, required this.tasks});
}
