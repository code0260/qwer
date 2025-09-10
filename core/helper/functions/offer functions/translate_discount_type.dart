import 'package:almonazim/core/constant/app_enums.dart';

OfferDiscountType translateToEnumOfferDiscountTypeFromString(String type) {
  switch (type) {
    case "نسبة":
      return OfferDiscountType.percentage;
    case "ثابت":
      return OfferDiscountType.fixed;
    default:
      return OfferDiscountType.fixed;
  }
}

OfferDiscountType translateToEnumOfferDiscountTypeFromEnString(String type) {
  switch (type) {
    case "percentage":
      return OfferDiscountType.percentage;
    case "fixed":
      return OfferDiscountType.fixed;
    default:
      return OfferDiscountType.fixed;
  }
}

String translateToArOfferDiscountType(OfferDiscountType? type) {
  switch (type) {
    case OfferDiscountType.percentage:
      return "نسبة";
    case OfferDiscountType.fixed:
      return "ثابت";
    default:
      return "ثابت";
  }
}

String translateToArOfferDiscountTypeFromString(String type) {
  switch (type) {
    case "percentage":
      return "نسبة";
    case "fixed":
      return "ثابت";
    default:
      return "ثابت";
  }
}

String translateToEnOfferDiscountTypeFromString(String type) {
  switch (type) {
    case "نسبة":
      return "percentage";
    case "ثابت":
      return "fixed";
    default:
      return "ثابت";
  }
}
