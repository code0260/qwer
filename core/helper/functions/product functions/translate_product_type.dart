import 'package:almonazim/core/constant/app_enums.dart';

// Arabic to English
String translateToArProductType(ProductType? productType) {
  switch (productType) {
    case ProductType.product:
      return "منتج";
    case ProductType.service:
      return "خدمة";
    default:
      return "غير معروف";
  }
}

// English to Arabic
ProductType? translateToEnProductType(String productType) {
  switch (productType) {
    case "منتج":
      return ProductType.product;
    case "خدمة":
      return ProductType.service;
    default:
      return null;
  }
}

// String to Arabic (from non-enum string types)
String translateToArProductTypeFromString(String productType) {
  switch (productType) {
    case "product":
      return "منتج";
    case "service":
      return "خدمة";
    default:
      return "غير معروف";
  }
}

// String to English (from Arabic strings)
String translateToEnProductTypeFromString(String productType) {
  switch (productType) {
    case "منتج":
      return "product";
    case "خدمة":
      return "service";
    default:
      return "unknown";
  }
}
