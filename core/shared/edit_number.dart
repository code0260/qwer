import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/my_snack_bar.dart';
import 'package:almonazim/core/helper/functions/valid_input_function.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:almonazim/core/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class EditNumber extends StatelessWidget {
  final String mainText;
  final TextEditingController numberController = TextEditingController();
  final IconData iconData;
  final String? defaultValue;
  EditNumber({
    super.key,
    required this.mainText,
    required this.iconData,
    required this.defaultValue,
  });
  @override
  Widget build(BuildContext context) {
    if (defaultValue != null) {
      numberController.text = defaultValue!;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
              hintText: mainText,
              autoFocus: true,
              label: "الرجاء إدخال $mainText ",
              iconData: iconData,
              controller: numberController,
              validator: (value) {
                return validInput(value!.trim(), 1, 50, 'number');
              },
              keyboardType: TextInputType.number),
          const SizedBox(
            height: 26,
          ),
          CustomButton(
            title: 'تعديل $mainText',
            color: AppColor.primaryColor,
            onPressed: () {
              String? errorMessage =
                  validInput(numberController.text.trim(), 1, 50, 'number');
              if (errorMessage == null) {
                Get.back(result: numberController.text.toDouble());
              } else {
                mySnackBar(ToastificationType.error, 'خطأ', errorMessage);
              }
            },
            padding: const EdgeInsets.symmetric(horizontal: 40),
          ),
        ],
      ),
    );
  }
}
