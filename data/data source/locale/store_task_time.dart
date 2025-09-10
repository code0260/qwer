import 'package:almonazim/core/helper/functions/datetime%20functions/format_time_of_day.dart';
import 'package:almonazim/core/helper/pref_storage.dart';
import 'package:flutter/material.dart';

class StoreTaskTime {
  StoreTaskTime._();

  /// Store TimeOfDay for a specific task
  static Future<void> setTaskTime(String taskName, TimeOfDay time) async {
    final String formatted = formatTimeOfDay(time);
    await PrefStorage.set('task_time_$taskName', formatted);
  }

  /// Retrieve TimeOfDay for a specific task
  static TimeOfDay? getTaskTime(String taskName) {
    final String? timeString = PrefStorage.get('task_time_$taskName');
    return parseTimeOfDay(timeString);
  }

  /// Remove stored upload time for a task
  static Future<void> clearTaskTime(String taskName) async {
    await PrefStorage.remove('task_time_$taskName');
  }
}
