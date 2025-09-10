import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnTransactionPartnerType(TransactionPartnerType? type) {
  switch (type) {
    case TransactionPartnerType.employee:
      return "employee";
    case TransactionPartnerType.client:
      return "client";
    case TransactionPartnerType.asset:
      return "asset";
    default:
      return null;
  }
}

String? translateToArTransactionPartnerType(TransactionPartnerType? type) {
  switch (type) {
    case TransactionPartnerType.employee:
      return "موظف";
    case TransactionPartnerType.client:
      return "عميل";
    case TransactionPartnerType.asset:
      return "أصل";
    default:
      return null;
  }
}

String? translateToEnTransactionPartnerTypeFromString(String? type) {
  switch (type) {
    case "موظف":
      return "employee";
    case "عميل":
      return "client";
    case "أصل":
      return "asset";
    default:
      return null;
  }
}

String? translateToArTransactionPartnerTypeFromString(String? type) {
  switch (type) {
    case "employee":
      return "موظف";
    case "client":
      return "عميل";
    case "asset":
      return "أصل";
    default:
      return null;
  }
}
