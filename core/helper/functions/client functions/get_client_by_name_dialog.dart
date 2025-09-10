import 'package:almonazim/core/helper/functions/custom%20dialogs/my_snack_bar.dart';
import 'package:almonazim/core/helper/functions/valid_input_function.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:almonazim/core/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

Future<String?> getClientByNameDialog(context) async {
  TextEditingController nameController = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'بحث باسم العميل',
          textAlign: TextAlign.center,
        ),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                  hintText: "اسم العميل",
                  label: "أدخل اسم العميل",
                  iconData: FontAwesomeIcons.fileInvoice,
                  controller: nameController,
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
                    if (nameController.text.isNotEmpty) {
                      Get.back(result: nameController.text);
                    } else if (nameController.text.isEmpty) {
                      mySnackBar(
                        ToastificationType.error,
                        'خطأ',
                        'الرجاء إدخال الاسم ',
                      );
                    }
                  },
                  title: 'بحث')
            ],
          ),
        ),
      );
    },
  );
}
