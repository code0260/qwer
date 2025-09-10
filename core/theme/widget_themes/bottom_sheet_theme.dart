import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class MyAppBottomSheetTheme {
  MyAppBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: AppColor.white,
    modalBackgroundColor: AppColor.white,
    constraints: const BoxConstraints(maxWidth: 768),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  );

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: AppColor.black,
    modalBackgroundColor: AppColor.black,
    constraints: const BoxConstraints(maxWidth: 768),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  );
}
