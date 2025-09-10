import 'package:almonazim/core/constant/app_color.dart';
import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<String?> selectDayOfAWeek(BuildContext context) {
  List<DayInWeek> days = [
    DayInWeek(
      dayKey: "Sun",
      "Sun",
    ),
    DayInWeek(
      dayKey: "Mon",
      "Mon",
    ),
    DayInWeek(dayKey: "Tue", "Tue"),
    DayInWeek(
      dayKey: "Wed",
      "Wed",
    ),
    DayInWeek(
      dayKey: "Thu",
      "Thu",
    ),
    DayInWeek(
      dayKey: "Fri",
      "Fri",
    ),
    DayInWeek(
      dayKey: "Sat",
      "Sat",
    ),
  ];
  return showDialog<String?>(
    context: context,
    builder: (context) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SelectWeekDays(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          days: days,
          border: false,
          boxDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              colors: [AppColor.primaryColor, AppColor.primaryColor],
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          onSelect: (values) {
            Get.back(result: values[0]);
          },
        ),
      ));
    },
  );
}
