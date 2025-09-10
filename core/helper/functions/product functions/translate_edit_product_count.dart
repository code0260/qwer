import 'package:almonazim/core/constant/app_enums.dart';

// Arabic to English
String translateToArEditCountReason(EditCountReason? reason) {
  switch (reason) {
    case EditCountReason.theft:
      return "سرقة";
    case EditCountReason.damage:
      return "تلف";
    case EditCountReason.errorRecord:
      return "خطأ تسجيل";
    default:
      return "غير معروف";
  }
}

// String to Arabic (from non-enum string types)
String translateToArEditCountReasonFromString(String reason) {
  switch (reason) {
    case "theft":
      return "سرقة";
    case "damage":
      return "تلف";
    case "errorRecord":
      return "خطأ تسجيل";
    default:
      return "غير معروف";
  }
}

// English to Arabic
EditCountReason? translateToEnEditCountReason(String reason) {
  switch (reason) {
    case "سرقة":
      return EditCountReason.theft;
    case "تلف":
      return EditCountReason.damage;
    case "خطأ تسجيل":
      return EditCountReason.errorRecord;
    default:
      return null;
  }
}

// String to English (from Arabic strings)
String translateToEnEditCountReasonFromString(String reason) {
  switch (reason) {
    case "سرقة":
      return "theft";
    case "تلف":
      return "damage";
    case "خطأ تسجيل":
      return "errorRecord";
    default:
      return "unknown";
  }
}
