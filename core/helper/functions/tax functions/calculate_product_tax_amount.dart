import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/data/model/taxes%20models/product_tax_model.dart';

double calculateProductTaxAmount(List<ProductTaxModel> taxes, double total,
    {List<TaxType>? allowedTaxTypes}) {
  double taxAmount = 0;
  double updateTotalAmount = total;
  // the taxes are ordered when they were got
  for (final tax in taxes) {
    if (!checkTaxType(tax.taxesType!, allowedTaxTypes)) {
      continue;
    }
    double thisTaxAmount =
        (tax.taxesRate!.toDouble() / 100) * updateTotalAmount;
    updateTotalAmount -= thisTaxAmount;
    taxAmount += thisTaxAmount;
  }

  return taxAmount;
}

bool checkTaxType(String taxType, List<TaxType>? allowedTaxTypes) {
  if (allowedTaxTypes == null) return true;
  for (final type in allowedTaxTypes) {
    if (type.name == taxType) {
      return true;
    }
  }
  return false;
}
