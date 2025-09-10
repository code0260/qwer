import 'package:almonazim/core/helper/functions/currency%20functions/prepare_sell_price_currency.dart';
import 'package:almonazim/core/helper/functions/tax%20functions/calculate_product_tax_amount.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/offer%20repo/apply%20offer%20repo/apply_offer_repo_imp.dart';
import 'package:almonazim/data/model/offer_model/total_offer_model.dart';

class TablePriceRSCNICubit extends SafeCubit<TotalOfferModel> {
  TablePriceRSCNICubit(this.applyOfferImp)
      : super(TotalOfferModel(
            currencyId: currentCurrencyModel.businessCurrencyId));
  ApplyOfferImp applyOfferImp;
  void getTotalPrice() {
    TotalOfferModel totalModel = TotalOfferModel(
        shippingCost: state.shippingCost,
        currencyId: currentCurrencyModel.businessCurrencyId);
    for (final entry in rSCNIHome) {
      var value = prepareSellPriceCurrency(
          rSCNIHome,
          rSCNIHome.indexWhere((item) =>
              item.getProductModel.productModel.productsId ==
              entry.getProductModel.productModel.productsId));
      if (value != null) rSCNIHome = value;
      var totalProduct = (entry.editedPriceModel.pricesUnitPrice ??
              entry.getProductModel.chosenPriceModel.pricesUnitPrice ??
              0) *
          (entry.productCount) *
          (entry.productConversion ?? 1);
      totalModel.undiscountedPrice += totalProduct;
      totalModel.taxAmount +=
          calculateProductTaxAmount(entry.taxes, totalProduct);
    }

    for (final entry in productDiscount.entries) {
      totalModel.discountedPrice += entry.value;
    }

    applyOfferImp.applyOffer(totalModel);
    emit(totalModel);
  }

  void updateShippingCost(double shippingCost) {
    emit(state.copyWith(shippingCost: shippingCost));
  }
}
