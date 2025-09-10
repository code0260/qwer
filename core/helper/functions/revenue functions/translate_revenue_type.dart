import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnRevenueTypeEnum(RevenueType? status) {
  switch (status) {
    case RevenueType.done:
      return "done";
    case RevenueType.prepaid:
      return "prepaid";
    case RevenueType.due:
      return "due";
    case RevenueType.all:
      return "all";
    default:
      return null;
  }
}

String? translateToArRevenueTypeEnum(RevenueType? status) {
  switch (status) {
    case RevenueType.done:
      return "تم";
    case RevenueType.prepaid:
      return "مدفوع مقدماً";
    case RevenueType.due:
      return "مستحق";
    case RevenueType.all:
      return "الكل";
    default:
      return null;
  }
}

String? translateToEnRevenueType(String? status) {
  switch (status) {
    case "تم":
      return "done";
    case "مدفوع مقدماً":
      return "prepaid";
    case "مستحق":
      return "due";
    case "الكل":
      return "all";
    default:
      return null;
  }
}

String? translateToArRevenueType(String? status) {
  switch (status) {
    case "done":
      return "تم";
    case "prepaid":
      return "مدفوع مقدماً";
    case "due":
      return "مستحق";
    case "all":
      return "الكل";
    default:
      return null;
  }
}
