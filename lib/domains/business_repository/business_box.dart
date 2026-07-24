import 'package:personal_ai_coach/data_providers/hive/hive_db.dart';
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
    List<SpecificTasks> newTasks = List.from(tasks);
    final existingTasks = await getWeeklyTasks();

    // for (var i = 0; i < res.length; i++) {
    //   for (var b = 0; b < tasks.length; b++) {
    //     if(res[i].day == tasks[b].day){
    //         for (var c = 0; c < res[i].tasks.length; c++) {
    //           for (var d = 0; d < tasks[b].tasks.length; d++) {
    //             if (res[i].tasks[c] ==  tasks[b].tasks[d]){
    //               tasks[b].tasks[d].primaryTask.copyWith(scheduledStartTime: )
    //             }
    //           }
    //         }
    //     }
    //   }
    // }
    final resByDay = {for (var r in existingTasks) r.day: r};

    final List<SpecificTasks> rescheduledTasks = [];

    newTasks = newTasks.map((taskGroup) {
      final matchedDay = resByDay[taskGroup.day];
      if (matchedDay == null) return taskGroup;
      final inComingDailySchedule = taskGroup.tasks
          .map((e) => e.primaryTask.scheduledStartTime)
          .toList();
      final existingDailySchedule = matchedDay.tasks
          .map((e) => e.primaryTask.scheduledStartTime)
          .toList();

      final finalTasks = taskGroup.tasks.map((element) {
        if (existingDailySchedule.contains(inComingDailySchedule[0])) {
          final temp = element.copyWith(
            primaryTask: element.primaryTask.reschedule(
              occupiedTimes: existingDailySchedule,
            ),
          );
          matchedDay.addToList(task: temp);
          rescheduledTasks.add(matchedDay);
          return temp;
        } else {
          matchedDay.addToList(task: element);
          rescheduledTasks.add(matchedDay);
          return element;
        }
      }).toList();

      return taskGroup.copyWith(tasks: finalTasks);
    }).toList();

    // existingTasks.map((e) {
    //       e.tasks.map((b)=>  )

    // });

    // for (var i = 0; i < existingTasks.length; i++) {
    //   tasks.where((element){

    //     if((element.day == existingTasks[i].day)  ){
    //       existingTasks[i].tasks.where((e){
    //           element.tasks.where((b)=> b.primaryTask.scheduledStartTime == e.primaryTask.scheduledStartTime );
    //       } );
    //     };
    //     return
    //   })
    // }

    // existingTasks.map((e){
    //   e.day == tasks.map((element){

    //   }  )
    // });
    // existingTasks.followedBy(newTasks);

    HiveDB.set(
      boxName: boxName,
      key: keys.weeklyTasks.index.toString(),
      value: rescheduledTasks.map((e) => e.toMap()),
    );
  }
}
