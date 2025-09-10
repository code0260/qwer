import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:get/get.dart';

String? validInput(String value, int min, int max, String type,
    {bool canBeEmpty = false}) {
  if (canBeEmpty == true) {
    if (value.isEmpty) {
      return null;
    }
  }

  if (value.isEmpty) {
    return 'هذا الحقل مطلوب';
  }
  if (value.length < min) {
    return "القيمة لا يمكن أن تكون أقل من $min";
  }

  if (value.length > max) {
    return "القيمة لا يمكن أن تكون أكبر من $max";
  }

  if (type == 'username') {
    if (!GetUtils.isUsername(value)) {
      return 'اسم المستخدم غير صالح';
    }
  }
  if (type == 'email') {
    if (!GetUtils.isEmail(value)) {
      return 'البريد الإلكتروني غير صالح';
    }
  }
  if (type == 'phone') {
    if (!GetUtils.isPhoneNumber(value)) {
      return 'رقم الهاتف غير صالح';
    }
  }
  if (type == 'number') {
    if (!GetUtils.isNum(value.fromFormattedNumber())) {
      return 'رقم غير صالح';
    }
  }
  if (type == "discount") {
    if (value.toInt() > 100) {
      return "لا يمكن أن يكون أكبر من 100٪";
    } else if (value.contains("%")) {
      return "يرجى إزالة علامة النسبة المئوية";
    }
  }
  return null;
}
