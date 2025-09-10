import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/prices%20functions/get_latest_unit_cost.dart';
import 'package:almonazim/core/helper/functions/prices%20functions/translate_prices_partner.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/edit_price_model.dart';
import 'package:almonazim/data/model/price%20models/prices_input_model.dart';

class EditSellPriceCubit extends SafeCubit<EditPriceModel> {
  EditSellPriceCubit() : super(EditPriceModel());
  void editSellPrice(int productsId, PriceInputModel newSellPriceModel) {
    int index = cartSellHome.indexWhere(
        (item) => item.getProductModel.productModel.productsId == productsId);
    cartSellHome[index].editedPriceModel = newSellPriceModel;
    cartSellHome[index].currencyId = currentCurrencyModel.businessCurrencyId;
    emit(EditPriceModel(
        currencyId: cartSellHome[index].currencyId,
        productsId: productsId,
        price: newSellPriceModel.pricesUnitPrice));
  }

  void refresh() {
    for (final item in cartSellHome) {
      emit(EditPriceModel(
          currencyId: item.currencyId,
          productsId: item.getProductModel.productModel.productsId,
          price: item.editedPriceModel.pricesUnitPrice ??
              item.getProductModel.chosenPriceModel.pricesUnitPrice));
    }
  }

  void editPriceBasedOnPercentage() async {
    for (final item in cartSellHome) {
      if (item.editedPriceModel.pricesUnitPrice == null &&
          (item.getProductModel.productModel.productsProfitPercentage != 0 &&
              item.getProductModel.productModel.productsProfitPercentage !=
                  null)) {
        var latestBuyPrice = (await getLatestUnitCost(item));
        // ignore: use_build_context_synchronously
        editSellPrice(
            item.getProductModel.productModel.productsId!,
            PriceInputModel(
                pricesUnitPrice: ((item.getProductModel.productModel
                                .productsProfitPercentage! /
                            100) *
                        latestBuyPrice) +
                    latestBuyPrice,
                pricesType: InvoiceType.sell.name,
                pricesPartnerEn: PricesPartner.price1.name,
                pricesPartnerAr: translateToArPricesPartnerFromString(
                    PricesPartner.price1.name)));
      }
    }
  }
}
