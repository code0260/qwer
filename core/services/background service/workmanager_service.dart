import 'package:flutter/material.dart';

//
class WorkmanagerManagerService {
  WorkmanagerManagerService._();

  // static final Workmanager workmanager = Workmanager();

  static Future<void> initialize() async {
    // await workmanager.initialize(
    //   callbackDispatcher,
    //   isInDebugMode: kDebugMode,
    // );
  }

  static Future<void> registerRefreshOfflineDataTask(
      {required TimeOfDay timeOfDay}) async {
    // final Duration delay = getDelayUntilTime(timeOfDay.hour, timeOfDay.minute);
    // await workmanager.registerPeriodicTask(
    //   AppBackgroundTasks.refreshOfflineDataName,
    //   AppBackgroundTasks.refreshOfflineDataName,
    //   frequency: const Duration(days: 1),
    //   initialDelay: delay,
    //   existingWorkPolicy: ExistingWorkPolicy.replace,
    //   constraints: Constraints(
    //     networkType: NetworkType.connected,
    //     requiresBatteryNotLow: true,
    //   ),
    // );
  }

  static Future<void> uploadInvoicesTask({required TimeOfDay timeOfDay}) async {
    // final Duration delay = getDelayUntilTime(timeOfDay.hour, timeOfDay.minute);
    // await workmanager.registerPeriodicTask(
    //   AppBackgroundTasks.uploadInvoicesName,
    //   AppBackgroundTasks.uploadInvoicesName,
    //   frequency: const Duration(days: 1),
    //   initialDelay: delay,
    //   existingWorkPolicy: ExistingWorkPolicy.replace,
    //   constraints: Constraints(
    //     networkType: NetworkType.connected,
    //     requiresBatteryNotLow: true,
    //   ),
    // );
  }

  static Future<void> cancelTask(String task) async {
    // await workmanager.cancelByUniqueName(task);
  }
}
