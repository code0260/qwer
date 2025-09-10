import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/prepare_buy_price_currency.dart';
import 'package:almonazim/core/helper/functions/offer%20functions/translate_discount_type.dart';
import 'package:almonazim/core/helper/functions/tax%20functions/calculate_product_tax_amount.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/total_price_model.dart';
import 'package:almonazim/data/model/offer_model/offer_model.dart';

class TablePriceBuyEditCubit extends SafeCubit<TotalPriceModel> {
  TablePriceBuyEditCubit()
      : super(TotalPriceModel(
            discountedPrice: 0,
            undiscountedPrice: 0,
            currencyId: currentCurrencyModel.businessCurrencyId));

  void getTotalPrice() {
    double totalTaxAmount = 0;
    double totalPrice = 0;
    for (final entry in cartBuyEditHome) {
      if (entry.batchModel.batchesProductsBuyPrice == null) {
        continue;
      }
      var value = prepareBuyPriceCurrency(
          cartBuyEditHome,
          cartBuyEditHome.indexWhere((item) =>
              item.productModel.productsId == entry.productModel.productsId));
      if (value != null) cartBuyEditHome = value;

      double totalProduct = entry.batchModel.batchesProductsBuyPrice! *
          ((entry.batchModel.batchesProductsTotalCount ?? 1) *
              (entry.batchModel.unitsConversionFactor ?? 1).toDouble());
      totalTaxAmount += calculateProductTaxAmount(entry.taxes, totalProduct);
      totalPrice += totalProduct;
    }

    double discountedValue = 0;
    if (state.discountType == OfferDiscountType.fixed) {
      discountedValue = totalPrice - state.discountValue;
    } else {
      discountedValue = totalPrice - (totalPrice * (state.discountValue / 100));
    }
    emit(state.copyWith(
        totalTaxAmount: totalTaxAmount,
        discountedPrice: discountedValue,
        undiscountedPrice: totalPrice,
        currencyId: currentCurrencyModel.businessCurrencyId));
  }

  void addDiscount(OfferModel offerModel) {
    double discountedValue = 0;
    if (offerModel.offersDiscountType == OfferDiscountType.fixed.name) {
      discountedValue =
          state.undiscountedPrice - offerModel.offersDiscountValue!;
    } else {
      discountedValue = state.undiscountedPrice -
          (state.undiscountedPrice * (offerModel.offersDiscountValue! / 100));
    }
    emit(state.copyWith(
      discountValue: offerModel.offersDiscountValue,
      discountType: translateToEnumOfferDiscountTypeFromEnString(
          offerModel.offersDiscountType!),
      discountedPrice: discountedValue,
    ));
  }

  void updateShippingCost(double shippingCost) {
    emit(state.copyWith(
      shippingCost: shippingCost,
    ));
  }
}
