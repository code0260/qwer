import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/my_snack_bar.dart';
import 'package:almonazim/core/helper/functions/valid_input_function.dart';
import 'package:almonazim/core/shared/buttons/custom_button.dart';
import 'package:almonazim/core/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

Future<String?> getInvoiceByNumberDialog(context) async {
  TextEditingController invoiceNumberController = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'بحث برقم الفاتورة',
          textAlign: TextAlign.center,
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                  hintText: "رقم الفاتورة",
                  label: "أدخل رقم الفاتورة",
                  iconData: FontAwesomeIcons.fileInvoice,
                  controller: invoiceNumberController,
                  validator: (value) {
                    return validInput(value!.trim(), 1, 20, 'text');
                  },
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                title: "بحث",
                color: AppColor.primaryColor,
                onPressed: () {
                  if (invoiceNumberController.text.isNotEmpty) {
                    Get.back(result: invoiceNumberController.text);
                  } else if (invoiceNumberController.text.isEmpty) {
                    mySnackBar(
                      ToastificationType.error,
                      'خطأ',
                      'الرجاء إدخال الرقم ',
                    );
                  }
                },
                padding: const EdgeInsets.symmetric(horizontal: 40),
              ),
            ],
          ),
        ),
      );
    },
  );
}
