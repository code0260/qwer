import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/shared/buttons/cancel_button.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showCustomActionDialog(
    BuildContext context, String action, String actionContent,
    {required void Function() onPressed, bool clip = true}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('تأكيد $action'),
        content: Text('هل أنت متأكد أنك تريد $actionContent'),
        actions: <Widget>[
          const CancelButton(),
          CustomButton(
            shadow: 0,
            onPressed: () {
              onPressed.call();
              Get.back();
            },
            style: const TextStyle(color: AppColor.primaryColor),
            color: AppColor.whiteBlackSame,
            title: clip ? action.substring(2) : action, // remove ال
          ),
        ],
      );
    },
  );
}
