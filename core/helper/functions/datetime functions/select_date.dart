import 'package:flutter/material.dart';

Future<DateTime?> selectDate(
  BuildContext context,
  DateTime? initialDate,
) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2030),
    // locale: const Locale("en")
  );
  if (picked != null && picked != initialDate) {
    return picked;
  } else {
    return null;
  }
}
