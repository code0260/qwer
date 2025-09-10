import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void mySnackBar(ToastificationType action, String title, String message,
    {BuildContext? context}) {
  Toastification toastification = Toastification();

  IconData iconData() {
    if (action == ToastificationType.error) {
      return Icons.error_outline_outlined;
    } else if (action == ToastificationType.success) {
      return Icons.check_circle_outline_outlined;
    } else if (action == ToastificationType.info) {
      return Icons.info_outline;
    } else {
      return Icons.warning_outlined;
    }
  }

  Color? colorValue() {
    if (!isDark) {
      return null;
    }
    if (action == ToastificationType.error) {
      return AppColor.red;
    } else if (action == ToastificationType.success) {
      return AppColor.green;
    } else if (action == ToastificationType.info) {
      return AppColor.blue;
    } else {
      return AppColor.primaryColor;
    }
  }

  toastification.show(
    primaryColor: colorValue(),
    type: action,
    icon: Icon(iconData()),
    style: ToastificationStyle.minimal,
    title: Text(
      title,
      style: TextStyle(color: AppColor.whiteBlackReverse),
    ),
    description: Text(
      message,
      style: TextStyle(color: AppColor.whiteBlackReverse),
    ),
    backgroundColor: AppColor.whiteBlackSame,
    showProgressBar: false,
    closeButton: ToastCloseButton(
      buttonBuilder: (context, onClose) => IconButton(
          icon: Icon(Icons.close, size: 18, color: AppColor.whiteBlackReverse),
          onPressed: onClose),
    ),
    autoCloseDuration: const Duration(seconds: 5),
  );
}
