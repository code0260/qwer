import 'package:almonazim/core/constant/app_enums.dart';

InvoiceType? toInvoiceTypeFromArString(String invoiceType) {
  switch (invoiceType) {
    case "بيع":
      return InvoiceType.sell;
    case "شراء":
      return InvoiceType.buy;
    case "مرتجع بيع":
      return InvoiceType.sellRefund;
    case "مرتجع شراء":
      return InvoiceType.buyRefund;
    case "الكل":
      return InvoiceType.all;
    default:
      return null;
  }
}

InvoiceType? toInvoiceTypeFromEnString(String invoiceType) {
  switch (invoiceType.toLowerCase()) {
    case "sell":
      return InvoiceType.sell;
    case "buy":
      return InvoiceType.buy;
    case "sellRefund":
      return InvoiceType.sellRefund;
    case "buyRefund":
      return InvoiceType.buyRefund;
    case "all":
      return InvoiceType.all;
    default:
      return null;
  }
}

String translateToArInvoiceType(InvoiceType? invoiceType) {
  switch (invoiceType) {
    case InvoiceType.sell:
      return "بيع";
    case InvoiceType.buy:
      return "شراء";
    case InvoiceType.sellRefund:
      return "مرتجع بيع";
    case InvoiceType.buyRefund:
      return "مرتجع شراء";
    case InvoiceType.all:
      return "الكل";
    default:
      return "غير معروف";
  }
}

String translateToArInvoiceTypeFromString(String invoiceType) {
  switch (invoiceType) {
    case "sell":
      return "بيع";
    case "buy":
      return "شراء";
    case "sellRefund":
      return "مرتجع بيع";
    case "buyRefund":
      return "مرتجع شراء";
    case "all":
      return "الكل";
    default:
      return "غير معروف";
  }
}

String translateToEnInvoiceTypeFromString(String invoiceType) {
  switch (invoiceType) {
    case "بيع":
      return "sell";
    case "شراء":
      return "buy";
    case "مرتجع بيع":
      return "sellRefund";
    case "مرتجع شراء":
      return "buyRefund";
    case "الكل":
      return "all";
    default:
      return "unknown";
  }
}
