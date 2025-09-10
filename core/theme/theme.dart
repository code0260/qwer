import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/theme/widget_themes/appbar_theme.dart';
import 'package:almonazim/core/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:almonazim/core/theme/widget_themes/checkbox_theme.dart';
import 'package:almonazim/core/theme/widget_themes/chip_theme.dart';
import 'package:almonazim/core/theme/widget_themes/elevated_button_theme.dart';
import 'package:almonazim/core/theme/widget_themes/outlined_button_theme.dart';
import 'package:almonazim/core/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

import 'widget_themes/text_field_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    tabBarTheme: const TabBarThemeData(
      indicatorColor: AppColor.primaryColor,
      labelColor: AppColor.primaryColor,
      unselectedLabelColor: AppColor.darkText,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColor.primaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
      shape: CircleBorder(),
      foregroundColor: AppColor.white,
    ),
    cardTheme: CardThemeData(
      color: AppColor.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    ),
    fontFamily: 'Cairo',
    popupMenuTheme: PopupMenuThemeData(
      textStyle: const TextStyle(color: AppColor.darkText),
      color: AppColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    ),
    disabledColor: AppColor.red,
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: AppColor.darkText),
    listTileTheme: const ListTileThemeData(
      leadingAndTrailingTextStyle: TextStyle(
        height: 2,
        fontFamily: 'Cairo',
        fontSize: 15.0,
        fontWeight: FontWeight.normal,
        color: AppColor.darkText,
        decorationColor: AppColor.primaryColor,
      ),
      textColor: AppColor.darkText,
      iconColor: AppColor.darkText,
    ),
    colorSchemeSeed: AppColor.primaryColor,
    textTheme: MyAppTextTheme.lightTextTheme,
    chipTheme: MyAppChipTheme.lightChipTheme,
    scaffoldBackgroundColor: AppColor.lightBackgroundColor,
    appBarTheme: MyAppAppBarTheme.lightAppBarTheme,
    radioTheme: const RadioThemeData(
      fillColor: WidgetStatePropertyAll(AppColor.primaryColor),
    ),
    checkboxTheme: MyAppCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: MyAppBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: MyAppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: MyAppOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MyAppTextFormFieldTheme.lightInputDecorationTheme,
    dialogTheme: const DialogThemeData(backgroundColor: AppColor.white),
    timePickerTheme: TimePickerThemeData(
      dialHandColor: AppColor.primaryColor,
      dialBackgroundColor: AppColor.light,
      backgroundColor: AppColor.white,
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith(
          (states) => AppColor.primaryColor,
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith(
          (states) => AppColor.black,
        ),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColor.white,
      dividerColor: AppColor.darkText,
      headerForegroundColor: AppColor.white,
      headerBackgroundColor: AppColor.primaryColor,
      rangePickerBackgroundColor: AppColor.primaryColor,
      rangeSelectionBackgroundColor: AppColor.primaryColor,
      rangePickerHeaderBackgroundColor: AppColor.primaryColor,
      todayForegroundColor: WidgetStateColor.resolveWith(
        (states) => AppColor.primaryColor,
      ),
      dayOverlayColor: WidgetStateColor.resolveWith(
        (states) => AppColor.primaryColor,
      ),
      yearForegroundColor: WidgetStateColor.resolveWith(
        (states) => AppColor.primaryColor,
      ),
      dayBackgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.primaryColor; // لون الدائرة نفسها!
        }
        return AppColor.white; // خلفية الأيام الأخرى
      }),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith(
          (states) => AppColor.primaryColor,
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith(
          (states) => AppColor.black,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    tabBarTheme: const TabBarThemeData(
      indicatorColor: AppColor.primaryColor,
      labelColor: AppColor.primaryColor,
      unselectedLabelColor: AppColor.white,
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColor.primaryColor,
    ),
    radioTheme: const RadioThemeData(
      fillColor: WidgetStatePropertyAll(AppColor.primaryColor),
    ),
    iconTheme: const IconThemeData(color: AppColor.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
      shape: CircleBorder(),
      foregroundColor: AppColor.white,
    ),
    cardTheme: CardThemeData(
      color: AppColor.dark,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    ),
    listTileTheme: const ListTileThemeData(
      leadingAndTrailingTextStyle: TextStyle(
        height: 2,
        fontFamily: 'Cairo',
        fontSize: 15.0,
        fontWeight: FontWeight.normal,
        color: AppColor.light,
        decorationColor: AppColor.primaryColor,
      ),
      iconColor: AppColor.light, // ← لو عم تستخدم ListTile للأزرار أو القوائم
      textColor: AppColor.light,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColor.dark,
      textStyle: const TextStyle(color: AppColor.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    ),
    fontFamily: 'Cairo',
    disabledColor: AppColor.grey,
    brightness: Brightness.dark,
    // primaryColor: AppColor.primaryColor,
    colorSchemeSeed: AppColor.primaryColor,
    textTheme: MyAppTextTheme.darkTextTheme,
    chipTheme: MyAppChipTheme.darkChipTheme,
    // scaffoldBackgroundColor: AppColor.dark,
    scaffoldBackgroundColor: AppColor.darkBackgroundColor,
    appBarTheme: MyAppAppBarTheme.darkAppBarTheme,
    checkboxTheme: MyAppCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: MyAppBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: MyAppElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: MyAppOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: MyAppTextFormFieldTheme.darkInputDecorationTheme,
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColor.darkBackgroundColor,
    ),
    timePickerTheme: TimePickerThemeData(
      dialHandColor: AppColor.primaryColor,
      dialBackgroundColor: AppColor.dark,
      backgroundColor: AppColor.darkBackgroundColor,
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith(
          (states) => AppColor.primaryColor,
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith(
          (states) => AppColor.white,
        ),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColor.darkBackgroundColor,
      dividerColor: AppColor.darkerGrey,
      headerForegroundColor: AppColor.darkBackgroundColor,
      dayForegroundColor: WidgetStateColor.resolveWith(
        (states) => AppColor.white,
      ),
      headerBackgroundColor: AppColor.primaryColor,
      todayBackgroundColor: WidgetStateColor.resolveWith(
        (states) => AppColor.darkBackgroundColor,
      ),
      todayForegroundColor: WidgetStateColor.resolveWith(
        (states) => AppColor.primaryColor,
      ),
      dayOverlayColor: WidgetStateColor.resolveWith(
        (states) => AppColor.primaryColor,
      ),
      yearForegroundColor: WidgetStateColor.resolveWith(
        (states) => AppColor.primaryColor,
      ),
      dayBackgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColor.primaryColor; // لون الدائرة نفسها!
        }
        return AppColor.darkBackgroundColor; // خلفية الأيام الأخرى
      }),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith(
          (states) => AppColor.primaryColor,
        ),
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateColor.resolveWith(
          (states) => AppColor.white,
        ),
      ),
    ),
  );

  AppTheme._();
}
