import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnExpenseTypeEnum(ExpenseType? status) {
  switch (status) {
    case ExpenseType.done:
      return "done";
    case ExpenseType.prepaid:
      return "prepaid";
    case ExpenseType.due:
      return "due";
    case ExpenseType.all:
      return "all";
    default:
      return null;
  }
}

String? translateToArExpenseTypeEnum(ExpenseType? status) {
  switch (status) {
    case ExpenseType.done:
      return "تم";
    case ExpenseType.prepaid:
      return "مدفوع مقدماً";
    case ExpenseType.due:
      return "مستحق";
    case ExpenseType.all:
      return "الكل";
    default:
      return null;
  }
}

String? translateToEnExpenseType(String? status) {
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

String? translateToArExpenseType(String? status) {
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
