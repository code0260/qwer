import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/tax%20functions/calculate_product_tax_amount.dart';
import 'package:almonazim/data.dart';

double calculateTotalBuyTax({List<TaxType>? allowedTaxTypes}) {
  double totalTax = 0;
  for (final entry in cartBuyHome) {
    var totalProduct = (entry.batchModel.batchesProductsBuyPrice! *
        entry.batchModel.batchesProductsTotalCount! *
        (entry.batchModel.unitsConversionFactor ?? 1));
    totalTax += calculateProductTaxAmount(entry.taxes, totalProduct,
        allowedTaxTypes: allowedTaxTypes);
  }
  return totalTax;
}
