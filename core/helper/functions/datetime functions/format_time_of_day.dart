import 'package:flutter/material.dart';

/// Helper: Convert TimeOfDay to "HH:mm"
String formatTimeOfDay(TimeOfDay time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

/// Helper: Convert "HH:mm" to TimeOfDay
TimeOfDay? parseTimeOfDay(String? timeString) {
  if (timeString == null) return null;
  final parts = timeString.split(":");
  if (parts.length != 2) return null;
  return TimeOfDay(
    hour: int.tryParse(parts[0]) ?? 0,
    minute: int.tryParse(parts[1]) ?? 0,
  );
}

bool isTime1BeforeTime2(TimeOfDay time1, TimeOfDay time2) {
  final int minutes1 = time1.hour * 60 + time1.minute;
  final int minutes2 = time2.hour * 60 + time2.minute;
  return minutes1 < minutes2;
}
