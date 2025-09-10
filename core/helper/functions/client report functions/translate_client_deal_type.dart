import 'package:almonazim/core/constant/app_enums.dart';

// Arabic to English (Enum to Arabic String)
String translateToArClientDealType(ClientDealType? dealType) {
  switch (dealType) {
    case ClientDealType.invoice:
      return "فاتورة";
    case ClientDealType.refund:
      return "مرتجع";
    case ClientDealType.payCash:
      return "دفع نقدي";
    case ClientDealType.payDebt:
      return "دفع دين";
    case ClientDealType.createDebt:
      return "إنشاء دين";
    case ClientDealType.invoiceShipping:
      return "تكلفة توصيل";
    case ClientDealType.refundShipping:
      return "مرتجع توصيل";
    default:
      return "غير معروف";
  }
}

// English String to Arabic String
String translateToArDealTypeFromString(String dealType) {
  switch (dealType) {
    case "invoice":
      return "فاتورة";
    case "refund":
      return "مرتجع";
    case "payCash":
      return "دفع نقدي";
    case "payDebt":
      return "دفع دين";
    case "createDebt":
      return "إنشاء دين";
    case "invoiceShipping":
      return "تكلفة توصيل";
    case "refundShipping":
      return "مرتجع توصيل";
    default:
      return "غير معروف";
  }
}

// Arabic String to Enum
ClientDealType? translateToEnClientDealType(String dealType) {
  switch (dealType) {
    case "فاتورة":
      return ClientDealType.invoice;
    case "مرتجع":
      return ClientDealType.refund;
    case "دفع نقدي":
      return ClientDealType.payCash;
    case "دفع دين":
      return ClientDealType.payDebt;
    case "إنشاء دين":
      return ClientDealType.createDebt;
    case "تكلفة توصيل":
      return ClientDealType.invoiceShipping;
    case "مرتجع توصيل":
      return ClientDealType.refundShipping;
    default:
      return null;
  }
}

// Arabic String to English String
String translateToEnDealTypeFromString(String dealType) {
  switch (dealType) {
    case "فاتورة":
      return "invoice";
    case "مرتجع":
      return "refund";
    case "دفع نقدي":
      return "payCash";
    case "دفع دين":
      return "payDebt";
    case "إنشاء دين":
      return "createDebt";
    case "تكلفة توصيل":
      return "invoiceShipping";
    case "مرتجع توصيل":
      return "refundShipping";
    default:
      return "unknown";
  }
}
