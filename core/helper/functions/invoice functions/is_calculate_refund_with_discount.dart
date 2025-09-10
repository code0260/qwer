import 'package:almonazim/core/helper/functions/custom%20dialogs/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> isCalculateRefundWithDiscount(BuildContext context) async {
  var value = false;
  await alertDialog(
    context: context,
    title: 'تنبيه',
    content:
        "هل سيتم حساب قيمة المرتجع بنسبة الخصم أو بالسعر الأصلي؟ \n\n مثال: فاتورة فيها 10 أقلام, قيمة كل قلم 10, ليكون المجموع 1,000 ويوجد خصم 10% فتصبح قيمة الفاتورة 900 \n\n ليكن المرتجع بقيمة قلمين, هل سيتم إرجاع 200 أو 180؟ \n إذا 180 اضغط بنسبة الخصم وإذا 200 اضغط بالسعر الأصلي  ",
    confirmText: "بنسبة الخصم",
    cancelText: 'بالسعر الأصلي',
    showCancel: true,
    onPressed: () async {
      value = true;
      Get.back(result: true);
    },
    onCancelButtonPressed: () {
      value = false;
      Get.back(result: false);
    },
  );
  return value;
}
