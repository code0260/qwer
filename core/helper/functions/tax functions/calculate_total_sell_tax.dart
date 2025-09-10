import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/tax%20functions/calculate_product_tax_amount.dart';
import 'package:almonazim/data.dart';

double calculateTotalSellTax({List<TaxType>? allowedTaxTypes}) {
  double totalTax = 0;
  for (final sellItemModel in cartSellHome) {
    if (sellItemModel.getProductModel.chosenPriceModel.pricesUnitPrice ==
            null &&
        sellItemModel.editedPriceModel.pricesUnitPrice == null) {
      throw Exception(
          'الرجاء إدخال سعر ${sellItemModel.getProductModel.productModel.productsName}');
    }
    var totalProduct = ((sellItemModel.editedPriceModel.pricesUnitPrice ??
            sellItemModel.getProductModel.chosenPriceModel.pricesUnitPrice!) *
        sellItemModel.productCount *
        (sellItemModel.productConversion ?? 1));
    totalTax += calculateProductTaxAmount(sellItemModel.taxes, totalProduct,
        allowedTaxTypes: allowedTaxTypes);
  }
  return totalTax;
}
