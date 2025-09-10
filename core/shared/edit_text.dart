import 'package:almonazim/core/helper/functions/custom%20dialogs/my_snack_bar.dart';
import 'package:almonazim/core/helper/functions/valid_input_function.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:almonazim/core/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class EditText extends StatelessWidget {
  final String mainText;
  final TextEditingController textController = TextEditingController();
  final IconData iconData;
  final String? defaultValue;
  EditText({
    super.key,
    required this.mainText,
    required this.iconData,
    this.defaultValue,
  });
  @override
  Widget build(BuildContext context) {
    if (defaultValue != null) {
      textController.text = defaultValue!;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
              autoFocus: true,
              hintText: mainText,
              label: "الرجاء إدخال $mainText ",
              iconData: iconData,
              controller: textController,
              validator: (value) {
                return validInput(value!.trim(), 1, 20, 'text');
              },
              keyboardType: TextInputType.text),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  Get.back(result: textController.text);
                } else if (textController.text.isEmpty) {
                  mySnackBar(ToastificationType.error, 'خطأ',
                      'الرجاء إدخال $mainText ');
                }
              },
              title: 'تم')
        ],
      ),
    );
  }
}
