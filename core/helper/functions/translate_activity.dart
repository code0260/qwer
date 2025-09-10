import 'package:almonazim/core/constant/app_enums.dart';

int? translateToEnActivity(Activity? activity) {
  switch (activity) {
    case Activity.active:
      return 1;
    case Activity.inactive:
      return 0;
    default:
      return null;
  }
}

String? translateToArActivity(Activity? activity) {
  switch (activity) {
    case Activity.active:
      return "نشط";
    case Activity.inactive:
      return "غير نشط";
    default:
      return null;
  }
}

int? translateToEnActivityFromString(String? activity) {
  switch (activity) {
    case "نشط":
      return 1;
    case "غير نشط":
      return 0;
    default:
      return null;
  }
}

String? translateToArActivityFromNum(int? activity) {
  switch (activity) {
    case 1:
      return "نشط";
    case 0:
      return "غير نشط";
    default:
      return null;
  }
}
