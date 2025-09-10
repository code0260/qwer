import 'dart:io';

import 'package:almonazim/core/constant/app_background_tasks.dart';
import 'package:almonazim/core/helper/functions/datetime%20functions/format_time_of_day.dart';
import 'package:almonazim/core/services/background%20service/workmanager_service.dart';
import 'package:almonazim/data/data%20source/locale/store_task_time.dart';

Future<void> initBackgroundWork() async {
  if (!Platform.isAndroid) {
    return;
  }
  // await WorkmanagerManagerService.initialize();

  //$ upload task
  var uploadTaskTime =
      StoreTaskTime.getTaskTime(AppBackgroundTasks.uploadInvoicesName);
  if (uploadTaskTime != null) {
    await WorkmanagerManagerService.uploadInvoicesTask(
        timeOfDay: uploadTaskTime);
  }
  //$ refresh task
  var refreshTaskTime =
      StoreTaskTime.getTaskTime(AppBackgroundTasks.refreshOfflineDataName);
  if (uploadTaskTime != null &&
      isTime1BeforeTime2(refreshTaskTime!, uploadTaskTime)) {
    // var newTime = TimeOfDay(hour: uploadTaskTime.hour + 1, minute: 0);
    // await StoreTaskTime.setTaskTime(
    //     AppBackgroundTasks.refreshOfflineDataName, newTime);
    // refreshTaskTime = newTime;
  }
  if (refreshTaskTime != null) {
    await WorkmanagerManagerService.registerRefreshOfflineDataTask(
        timeOfDay: refreshTaskTime);
  }
}
