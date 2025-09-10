import 'package:almonazim/core/helper/functions/currency%20functions/prepare_buy_price_id_and_currency.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/edit_price_model.dart';

class EditRBCNIPriceCubit extends SafeCubit<EditPriceModel> {
  EditRBCNIPriceCubit() : super(EditPriceModel());
  int? originalPriceId;
  void editRBCNIPrice(
      int productsId, double newRBCNIPrice, num? originalRBCNIPrice) {
    int index = rBCNIHome
        .indexWhere((item) => item.productModel.productsId == productsId);
    rBCNIHome[index].batchModel.batchesProductsBuyPrice = newRBCNIPrice;
    rBCNIHome[index].batchModel.batchesProductsId = productsId;
    // price edit
    originalPriceId ??=
        rBCNIHome[index].batchModel.batchesProductsPricesId ?? 0;
    var value = prepareBuyPriceIdAndCurrency(
        rBCNIHome, index, newRBCNIPrice, originalRBCNIPrice, originalPriceId!);
    rBCNIHome = value;
    emit(EditPriceModel(
        productsId: productsId,
        currencyId: rBCNIHome[index].batchModel.batchesProductsCurrencyId,
        price: rBCNIHome[index].batchModel.batchesProductsBuyPrice));
  }

  void refresh() {
    for (final item in rBCNIHome) {
      emit(EditPriceModel(
          productsId: item.productModel.productsId,
          currencyId: item.batchModel.batchesProductsCurrencyId,
          price: item.batchModel.batchesProductsBuyPrice));
    }
  }
}
