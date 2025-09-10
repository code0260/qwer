import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';
import 'package:almonazim/core/helper/functions/custom%20dialogs/my_snack_bar.dart';

void copyText(String text) {
  Clipboard.setData(ClipboardData(text: text)).then((_) {
    mySnackBar(ToastificationType.success, 'تم النسخ', "تم نسخ النص بنجاح");
  });
}
