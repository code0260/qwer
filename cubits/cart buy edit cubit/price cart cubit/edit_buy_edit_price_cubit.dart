import 'package:almonazim/core/helper/functions/currency%20functions/prepare_buy_price_id_and_currency.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/edit_price_model.dart';

class EditBuyEditPriceCubit extends SafeCubit<EditPriceModel> {
  EditBuyEditPriceCubit() : super(EditPriceModel());
  int? originalPriceId;
  void editBuyEditPrice(
      int productsId, double newBuyEditPrice, num? originalBuyEditPrice) {
    int index = cartBuyEditHome
        .indexWhere((item) => item.productModel.productsId == productsId);
    cartBuyEditHome[index].batchModel.batchesProductsBuyPrice = newBuyEditPrice;
    cartBuyEditHome[index].batchModel.batchesProductsId = productsId;
    // price edit
    originalPriceId ??=
        cartBuyEditHome[index].batchModel.batchesProductsPricesId ?? 0;
    var value = prepareBuyPriceIdAndCurrency(cartBuyEditHome, index,
        newBuyEditPrice, originalBuyEditPrice, originalPriceId!);
    cartBuyEditHome = value;
    emit(EditPriceModel(
        productsId: productsId,
        currencyId: cartBuyEditHome[index].batchModel.batchesProductsCurrencyId,
        price: cartBuyEditHome[index].batchModel.batchesProductsBuyPrice));
  }

  void refresh() {
    for (final item in cartBuyEditHome) {
      emit(EditPriceModel(
          productsId: item.productModel.productsId,
          currencyId: item.batchModel.batchesProductsCurrencyId,
          price: item.batchModel.batchesProductsBuyPrice));
    }
  }
}
