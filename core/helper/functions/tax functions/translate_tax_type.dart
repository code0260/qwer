import 'package:almonazim/core/constant/app_enums.dart';

String? translateToEnTaxType(TaxType? type) {
  switch (type) {
    case TaxType.vat:
      return "VAT";
    case TaxType.luxury:
      return "Luxury Tax";
    case TaxType.other:
      return "Other";
    default:
      return null;
  }
}

String? translateToArTaxType(TaxType? type) {
  switch (type) {
    case TaxType.vat:
      return "ضريبة القيمة المضافة";
    case TaxType.luxury:
      return "الضريبة الترفيهية";
    case TaxType.other:
      return "أخرى";
    default:
      return null;
  }
}

String? translateToEnTaxTypeFromString(String? type) {
  switch (type) {
    case "ضريبة القيمة المضافة":
      return "vat";
    case "الضريبة الترفيهية":
      return "luxury";
    case "أخرى":
      return "other";
    default:
      return null;
  }
}

String? translateToArTaxTypeFromString(String? type) {
  switch (type) {
    case "vat":
      return "ضريبة القيمة المضافة";
    case "luxury":
      return "الضريبة الترفيهية";
    case "other":
      return "أخرى";
    default:
      return null;
  }
}
