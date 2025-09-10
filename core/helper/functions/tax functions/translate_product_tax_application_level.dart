import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnProductTaxApplicationLevel(
    ProductTaxApplicationLevel? level) {
  switch (level) {
    case ProductTaxApplicationLevel.buy:
      return "buy";
    case ProductTaxApplicationLevel.sell:
      return "sell";
    case ProductTaxApplicationLevel.both:
      return "both";
    default:
      return null;
  }
}

String? translateToArProductTaxApplicationLevel(
    ProductTaxApplicationLevel? level) {
  switch (level) {
    case ProductTaxApplicationLevel.buy:
      return "شراء";
    case ProductTaxApplicationLevel.sell:
      return "بيع";
    case ProductTaxApplicationLevel.both:
      return "بيع/شراء";
    default:
      return null;
  }
}

String? translateToEnProductTaxApplicationLevelFromString(String? level) {
  switch (level) {
    case "شراء":
      return "buy";
    case "بيع":
      return "sell";
    case "بيع/شراء":
      return "both";
    default:
      return null;
  }
}

String? translateToArProductTaxApplicationLevelFromString(String? level) {
  switch (level) {
    case "buy":
      return "شراء";
    case "sell":
      return "بيع";
    case "both":
      return "بيع/شراء";
    default:
      return null;
  }
}
