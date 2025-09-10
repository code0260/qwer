import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/shared/buttons/cancel_button.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:flutter/material.dart';

Future<dynamic> alertDialog(
    {required context,
    required String title,
    required String content,
    required String confirmText,
    void Function()? onCancelButtonPressed,
    String? cancelText,
    bool showCancel = true,
    bool isDismissible = true,
    Color? confirmButtonColor = AppColor.primaryColor,
    required void Function() onPressed}) async {
  // AwesomeDialog(
  //           context: context,
  //           dialogType: DialogType.warning,
  //           animType: AnimType.rightSlide,
  //           title: title,
  //           desc: content,
  //           btnCancelOnPress: () {},
  //           btnOkOnPress: () {},
  //           )..show();
  await showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(content),
          actions: [
            if (showCancel)
              CancelButton(title: cancelText, onPressed: onCancelButtonPressed),
            CustomButton(
                title: confirmText,
                color: confirmButtonColor,
                onPressed: onPressed)
          ],
        );
      });
}
