import 'package:almonazim/core/constant/app_enums.dart';

// Arabic to English
String translateToArEditCashReason(EditCashReason? reason) {
  switch (reason) {
    case EditCashReason.theft:
      return "سرقة";
    case EditCashReason.damage:
      return "تلف";
    case EditCashReason.errorRecord:
      return "خطأ تسجيل";
    case EditCashReason.lost:
      return "ضياع";
    default:
      return "غير معروف";
  }
}

// String to Arabic (from non-enum string types)
String translateToArEditCashReasonFromString(String reason) {
  switch (reason) {
    case "theft":
      return "سرقة";
    case "damage":
      return "تلف";
    case "errorRecord":
      return "خطأ تسجيل";
    case "lost":
      return "ضياع";
    default:
      return "غير معروف";
  }
}

// English to Arabic
EditCashReason? translateToEnEditCashReason(String reason) {
  switch (reason) {
    case "سرقة":
      return EditCashReason.theft;
    case "تلف":
      return EditCashReason.damage;
    case "خطأ تسجيل":
      return EditCashReason.errorRecord;
    case "ضياع":
      return EditCashReason.lost;
    default:
      return null;
  }
}

// String to English (from Arabic strings)
String translateToEnEditCashReasonFromString(String reason) {
  switch (reason) {
    case "سرقة":
      return "theft";
    case "تلف":
      return "damage";
    case "خطأ تسجيل":
      return "errorRecord";
    case "ضياع":
      return "lost";
    default:
      return "unknown";
  }
}
