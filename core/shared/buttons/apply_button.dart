// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({super.key, this.onPressed, this.title});
  final void Function()? onPressed;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: title ?? "تطبيق",
      // color: AppColor.backgroundWhiteBlackSame,
      color: Theme.of(context).dialogTheme.backgroundColor,
      onPressed: onPressed ??
          () {
            Get.back(result: true);
          },
      shadow: 0,
      style: const TextStyle(color: AppColor.primaryColor),
    );
  }
}
