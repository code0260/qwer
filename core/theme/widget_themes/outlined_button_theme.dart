import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';

/* -- Light & Dark Outlined Button Themes -- */
class MyAppOutlinedButtonTheme {
  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColor.darkText,
      side: const BorderSide(color: AppColor.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16, color: AppColor.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColor.light,
      side: const BorderSide(color: AppColor.borderPrimary),
      textStyle: const TextStyle(
          fontSize: 16, color: AppColor.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
  );

  MyAppOutlinedButtonTheme._(); //To avoid creating instances
}
