import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';

/* -- Light & Dark Elevated Button Themes -- */
class MyAppElevatedButtonTheme {
  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColor.light,
      backgroundColor: AppColor.primaryColor,
      disabledForegroundColor: AppColor.darkGrey,
      disabledBackgroundColor: AppColor.buttonDisabled,
      side: const BorderSide(color: AppColor.primaryColor),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
      textStyle: const TextStyle(
          fontFamily: "Cairo",
          color: AppColor.lightGrey,
          fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColor.light,
      backgroundColor: AppColor.primaryColor,
      disabledForegroundColor: AppColor.darkGrey,
      disabledBackgroundColor: AppColor.darkerGrey,
      side: const BorderSide(color: AppColor.primaryColor),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
      textStyle: const TextStyle(
          fontFamily: "Cairo",
          color: AppColor.lightGrey,
          fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    ),
  );

  MyAppElevatedButtonTheme._(); //To avoid creating instances
}
