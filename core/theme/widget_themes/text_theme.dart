import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';

/// Custom Class for Light & Dark Text Themes
class MyAppTextTheme {
  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      color: AppColor.darkText,
      decorationColor: AppColor.primaryColor,
    ),
    headlineMedium: const TextStyle().copyWith(
      color: AppColor.darkText,
      decorationColor: AppColor.primaryColor,
    ),
    headlineSmall: const TextStyle().copyWith(
      color: AppColor.darkText,
      decorationColor: AppColor.primaryColor,
    ),
    titleLarge: const TextStyle().copyWith(
      color: AppColor.darkText,
      decorationColor: AppColor.primaryColor,
    ),
    titleMedium: const TextStyle().copyWith(
      color: AppColor.darkText,
      decorationColor: AppColor.primaryColor,
    ),
    titleSmall: const TextStyle().copyWith(
      color: AppColor.darkText,
      decorationColor: AppColor.primaryColor,
    ),
    bodyLarge: const TextStyle().copyWith(
      color: AppColor.darkText,
      decorationColor: AppColor.primaryColor,
    ),
    bodyMedium: const TextStyle().copyWith(
      height: 2,
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
      color: AppColor.darkText,
      decorationColor: AppColor.primaryColor,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColor.darkText.withOpacity(0.5),
      decorationColor: AppColor.primaryColor,
    ),
    labelLarge: const TextStyle().copyWith(
      color: AppColor.darkText,
      decorationColor: AppColor.primaryColor,
    ),
    labelMedium: const TextStyle().copyWith(
      color: AppColor.darkText.withOpacity(0.5),
      decorationColor: AppColor.primaryColor,
    ),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      color: AppColor.white,
      decorationColor: AppColor.primaryColor,
    ),
    headlineMedium: const TextStyle().copyWith(
      color: AppColor.white,
      decorationColor: AppColor.primaryColor,
    ),
    headlineSmall: const TextStyle().copyWith(
      color: AppColor.white,
      decorationColor: AppColor.primaryColor,
    ),
    titleLarge: const TextStyle().copyWith(
      color: AppColor.white,
      decorationColor: AppColor.primaryColor,
    ),
    titleMedium: const TextStyle().copyWith(
      color: AppColor.white,
      decorationColor: AppColor.primaryColor,
    ),
    titleSmall: const TextStyle().copyWith(
      color: AppColor.white,
      decorationColor: AppColor.primaryColor,
    ),
    bodyLarge: const TextStyle().copyWith(
      color: AppColor.white,
      decorationColor: AppColor.primaryColor,
    ),
    bodyMedium: const TextStyle().copyWith(
      height: 2,
      fontSize: 15.0,
      fontWeight: FontWeight.normal,
      color: AppColor.white,
      decorationColor: AppColor.primaryColor,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColor.white.withOpacity(0.5),
      decorationColor: AppColor.primaryColor,
    ),
    labelLarge: const TextStyle().copyWith(
      color: AppColor.white,
      decorationColor: AppColor.primaryColor,
    ),
    labelMedium: const TextStyle().copyWith(
      color: AppColor.white.withOpacity(0.5),
      decorationColor: AppColor.primaryColor,
    ),
  );

  MyAppTextTheme._(); // To avoid creating instances
}
