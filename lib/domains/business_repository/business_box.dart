import 'package:personal_ai_coach/data_providers/hive/hive_db.dart';
import 'package:personal_ai_coach/domains/business_repository/models/task.dart';
import 'package:personal_ai_coach/domains/business_repository/models/specific_tasks.dart';

enum keys { weeklyTasks }

abstract class BusinessBox {
  static String boxName = 'business';
  static bool isOpen = false;

  static Future<void> open() async {
    if (!isOpen) {
      await HiveDB.openBox(boxName: boxName);
      isOpen = true;
    }
  }

  static Future<List<SpecificTasks>> getWeeklyTasks() async {
    final res = await HiveDB.get(
      boxName: boxName,
      key: keys.weeklyTasks.index.toString(),
    );
    final temp = List.from(res).map((e) => SpecificTasks.fromMap(e)).toList();
    return temp;
  }

  static Future<void> setWeeklyTasks(List<SpecificTasks> tasks) async {
    final res = await getWeeklyTasks();
    // res.where((e)=> e.tasks.where((e)=> e.primaryTask.scheduledStartTime == tasks ))
    HiveDB.set(
      boxName: boxName,
      key: keys.weeklyTasks.index.toString(),
      value: tasks.map((e) => e.toMap()),
    );
  }
}
