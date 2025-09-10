import 'package:almonazim/core/constant/app_enums.dart';

// Arabic to English (Enum to Arabic String)
String translateToArCashDealType(CashDealType? dealType) {
  switch (dealType) {
    case CashDealType.payCash:
      return "دفع نقدي";
    case CashDealType.receiveDebt:
      return "تحصيل دين";
    case CashDealType.payDebt:
      return "سداد دين";
    case CashDealType.createDebt:
      return "إنشاء دين";
    case CashDealType.variant:
      return "منوع";
    case CashDealType.expense:
      return "مصروف";
    case CashDealType.revenue:
      return "إيراد";
    case CashDealType.withdrawal:
      return "سحب";
    case CashDealType.deposit:
      return "إيداع";
    default:
      return "منوع";
  }
}

// English String to Arabic String
String translateToArCashDealTypeFromString(String dealType) {
  switch (dealType) {
    case "payCash":
      return "دفع نقدي";
    case "receiveDebt":
      return "تحصيل دين";
    case "payDebt":
      return "سداد دين";
    case "createDebt":
      return "إنشاء دين";
    case "variant":
      return "منوع";
    case "expense":
      return "مصروف";
    case "revenue":
      return "إيراد";
    case "withdrawal":
      return "سحب";
    case "deposit":
      return "إيداع";
    default:
      return "منوع";
  }
}

// Arabic String to Enum
CashDealType? translateToEnCashDealType(String dealType) {
  switch (dealType) {
    case "دفع نقدي":
      return CashDealType.payCash;
    case "تحصيل دين":
      return CashDealType.receiveDebt;
    case "سداد دين":
      return CashDealType.payDebt;
    case "إنشاء دين":
      return CashDealType.createDebt;
    case "منوع":
      return CashDealType.variant;
    case "مصروف":
      return CashDealType.expense;
    case "إيراد":
      return CashDealType.revenue;
    case "سحب":
      return CashDealType.withdrawal;
    case "إيداع":
      return CashDealType.deposit;
    default:
      return CashDealType.variant;
  }
}

// Arabic String to English String
String translateToEnCashDealTypeFromString(String dealType) {
  switch (dealType) {
    case "دفع نقدي":
      return "payCash";
    case "تحصيل دين":
      return "receiveDebt";
    case "سداد دين":
      return "payDebt";
    case "إنشاء دين":
      return "createDebt";
    case "منوع":
      return "variant";
    case "مصروف":
      return "expense";
    case "إيراد":
      return "revenue";
    case "سحب":
      return "withdrawal";
    case "إيداع":
      return "deposit";
    default:
      return "variant";
  }
}
