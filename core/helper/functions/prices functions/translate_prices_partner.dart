import 'package:almonazim/core/constant/app_enums.dart';

PricesPartner? toPricesPartnerFromArString(String pricePartner) {
  switch (pricePartner) {
    case "سعر1":
      return PricesPartner.price1;
    case "سعر2":
      return PricesPartner.price2;
    case "سعر3":
      return PricesPartner.price3;
    case "سعر4":
      return PricesPartner.price4;
    case "سعر5":
      return PricesPartner.price5;
    default:
      return null;
  }
}

PricesPartner? toPricesPartnerFromEnString(String pricePartner) {
  switch (pricePartner.toLowerCase()) {
    case "price1":
      return PricesPartner.price1;
    case "price2":
      return PricesPartner.price2;
    case "price3":
      return PricesPartner.price3;
    case "price4":
      return PricesPartner.price4;
    case "price5":
      return PricesPartner.price5;
    default:
      return null;
  }
}

String translateToArPricesPartner(PricesPartner? pricePartner) {
  switch (pricePartner) {
    case PricesPartner.price1:
      return "سعر1";
    case PricesPartner.price2:
      return "سعر2";
    case PricesPartner.price3:
      return "سعر3";
    case PricesPartner.price4:
      return "سعر4";
    case PricesPartner.price5:
      return "سعر5";
    default:
      return "غير معروف";
  }
}

String translateToArPricesPartnerFromString(String pricePartner) {
  switch (pricePartner) {
    case "price1":
      return "سعر1";
    case "price2":
      return "سعر2";
    case "price3":
      return "سعر3";
    case "price4":
      return "سعر4";
    case "price5":
      return "سعر5";
    default:
      return "غير معروف";
  }
}

String translateToEnPricesPartnerFromString(String pricePartner) {
  switch (pricePartner) {
    case "سعر1":
      return "price1";
    case "سعر2":
      return "price2";
    case "سعر3":
      return "price3";
    case "سعر4":
      return "price4";
    case "سعر5":
      return "price5";
    default:
      return "غير معروف";
  }
}
