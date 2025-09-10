import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/cart%20models/edit_price_model.dart';
import 'package:almonazim/data/model/price%20models/prices_input_model.dart';

class EditRSCNIPriceCubit extends SafeCubit<EditPriceModel> {
  EditRSCNIPriceCubit() : super(EditPriceModel());
  void editRSCNIPrice(int productsId, PriceInputModel newRSCNIPriceModel) {
    int index = rSCNIHome.indexWhere(
        (item) => item.getProductModel.productModel.productsId == productsId);
    rSCNIHome[index].editedPriceModel = newRSCNIPriceModel;
    rSCNIHome[index].currencyId = currentCurrencyModel.businessCurrencyId;
    emit(EditPriceModel(
        currencyId: currentCurrencyModel.businessCurrencyId,
        productsId: productsId,
        price: newRSCNIPriceModel.pricesUnitPrice));
  }

  void refresh() {
    for (final item in rSCNIHome) {
      emit(EditPriceModel(
          currencyId: item.currencyId,
          productsId: item.getProductModel.productModel.productsId,
          price: item.editedPriceModel.pricesUnitPrice ??
              item.getProductModel.chosenPriceModel.pricesUnitPrice));
    }
  }
}
