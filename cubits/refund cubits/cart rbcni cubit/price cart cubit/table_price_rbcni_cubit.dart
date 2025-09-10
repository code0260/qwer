import 'package:almonazim/core/helper/functions/currency%20functions/prepare_buy_price_currency.dart';
import 'package:almonazim/core/helper/functions/tax%20functions/calculate_product_tax_amount.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/total_price_model.dart';

class TablePriceRBCNICubit extends SafeCubit<TotalPriceModel> {
  TablePriceRBCNICubit()
      : super(TotalPriceModel(
            discountedPrice: 0,
            undiscountedPrice: 0,
            currencyId: currentCurrencyModel.businessCurrencyId));

  void getTotalPrice() {
    double totalTaxAmount = 0;
    double totalPrice = 0;
    for (final entry in rBCNIHome) {
      if (entry.batchModel.batchesProductsBuyPrice == null) {
        continue;
      }
      var value = prepareBuyPriceCurrency(
          rBCNIHome,
          rBCNIHome.indexWhere((item) =>
              item.productModel.productsId == entry.productModel.productsId));
      if (value != null) rBCNIHome = value;

      double totalProduct = entry.batchModel.batchesProductsBuyPrice! *
          ((entry.batchModel.batchesProductsTotalCount ?? 1) *
              (entry.batchModel.unitsConversionFactor ?? 1));
      totalTaxAmount += calculateProductTaxAmount(entry.taxes, totalProduct);
      totalPrice += totalProduct;
    }
    emit(state.copyWith(
        totalTaxAmount: totalTaxAmount,
        discountedPrice: totalPrice,
        undiscountedPrice: totalPrice,
        currencyId: currentCurrencyModel.businessCurrencyId));
  }

  void updateDiscountedPrice(double discountedPrice) {
    emit(state.copyWith(
      discountedPrice: discountedPrice,
    ));
  }

  void updateShippingCost(double shippingCost) {
    emit(state.copyWith(
      shippingCost: shippingCost,
    ));
  }
}
