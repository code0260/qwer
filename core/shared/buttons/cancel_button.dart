import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelButton extends StatelessWidget {
  final String? title;
  final void Function()? onPressed;
  const CancelButton({
    super.key,
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: title ?? "إلغاء",
      color: Theme.of(context).dialogTheme.backgroundColor,
      onPressed: onPressed ??
          () {
            Get.back();
          },
      shadow: 0,
      style: TextStyle(color: AppColor.whiteMainReverse),
    );
  }
}
