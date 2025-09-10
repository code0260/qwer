import 'package:almonazim/core/helper/functions/currency%20functions/prepare_buy_price_id_and_currency.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/edit_price_model.dart';

class EditBuyPriceCubit extends SafeCubit<EditPriceModel> {
  EditBuyPriceCubit() : super(EditPriceModel());
  int? originalPriceId;
  void editBuyPrice(int productsId, double newBuyPrice, num? originalBuyPrice) {
    int index = cartBuyHome
        .indexWhere((item) => item.productModel.productsId == productsId);
    cartBuyHome[index].batchModel.batchesProductsBuyPrice = newBuyPrice;
    cartBuyHome[index].batchModel.batchesProductsId = productsId;
    // price edit
    originalPriceId ??=
        cartBuyHome[index].batchModel.batchesProductsPricesId ?? 0;
    var value = prepareBuyPriceIdAndCurrency(
        cartBuyHome, index, newBuyPrice, originalBuyPrice, originalPriceId!);
    cartBuyHome = value;
    emit(EditPriceModel(
        productsId: productsId,
        currencyId: cartBuyHome[index].batchModel.batchesProductsCurrencyId,
        price: cartBuyHome[index].batchModel.batchesProductsBuyPrice));
  }

  void refresh() {
    for (final item in cartBuyHome) {
      emit(EditPriceModel(
          productsId: item.productModel.productsId,
          currencyId: item.batchModel.batchesProductsCurrencyId,
          price: item.batchModel.batchesProductsBuyPrice));
    }
  }
}
