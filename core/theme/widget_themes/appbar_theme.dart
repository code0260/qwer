import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class MyAppAppBarTheme {
  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 1,
    // toolbarHeight: 52,
    backgroundColor: AppColor.white,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: AppColor.darkText,
      size: 22,
    ),
    actionsIconTheme: IconThemeData(color: AppColor.darkText, size: 22),
    titleTextStyle: TextStyle(
        fontFamily: "Cairo",
        fontSize: 20,
        color: AppColor.darkText,
        fontWeight: FontWeight.bold),
  );

  static const darkAppBarTheme = AppBarTheme(
    // toolbarHeight: 52,
    titleTextStyle: TextStyle(
        fontFamily: "Cairo",
        fontSize: 20,
        color: AppColor.lightGrey,
        fontWeight: FontWeight.bold),
    backgroundColor: Color(0xFF2F2F2F),
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 1,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColor.lightGrey, size: 22),
    actionsIconTheme: IconThemeData(color: AppColor.lightGrey, size: 22),
  );
  MyAppAppBarTheme._();
}
