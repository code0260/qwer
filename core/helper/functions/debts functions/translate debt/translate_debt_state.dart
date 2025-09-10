import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnDebtStateEnum(DebtState? state) {
  switch (state) {
    case DebtState.paid:
      return "paid";
    case DebtState.unpaid:
      return "unpaid";
    case DebtState.partial:
      return "partial";
    case DebtState.dead:
      return "dead";
    case DebtState.forgiven:
      return "forgiven";
    default:
      return null;
  }
}

String? translateToArDebtStateEnum(DebtState? state) {
  switch (state) {
    case DebtState.paid:
      return "مدفوع";
    case DebtState.unpaid:
      return "غير مدفوع";
    case DebtState.partial:
      return "مدفوع جزئياً";
    case DebtState.dead:
      return "معدوم";
    case DebtState.forgiven:
      return "مُسامَح";
    default:
      return null;
  }
}

String? translateToEnDebtState(String? state) {
  switch (state) {
    case "مدفوع":
      return "paid";
    case "غير مدفوع":
      return "unpaid";
    case "مدفوع جزئياً":
      return "partial";
    case "معدوم":
      return "dead";
    case "مُسامَح":
      return "forgiven";
    default:
      return null;
  }
}

String? translateToArDebtState(String? state) {
  switch (state) {
    case "paid":
      return "مدفوع";
    case "unpaid":
      return "غير مدفوع";
    case "partial":
      return "مدفوع جزئياً";
    case "dead":
      return "معدوم";
    case "forgiven":
      return "مُسامَح";
    default:
      return null;
  }
}
