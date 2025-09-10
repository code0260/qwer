import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/product%20place%20models/product_place_details_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_sell_product_place_state.dart';

class EditSellProductPlaceCubit extends SafeCubit<EditSellProductPlaceState> {
  EditSellProductPlaceCubit()
      : super(const EditSellProductPlaceItem(id: -10, isAdd: false));

  List<ProductPlaceDetailsModel> chosenPlaces = [];

  void doneStoreProductPlace(int productsId) {
    int index = cartSellHome.indexWhere(
        (item) => item.getProductModel.productModel.productsId == productsId);
    cartSellHome[index].chosenPlaceModels.clear();
    cartSellHome[index].chosenPlaceModels.addAll(chosenPlaces);
  }

  void addProductPlace(ProductPlaceDetailsModel chosenPlaceModel) {
    chosenPlaces.add(chosenPlaceModel);
    emit(EditSellProductPlaceItem(
        id: chosenPlaceModel.productPlaceModel.productPlacesId!, isAdd: true));
  }

  void deleteProductPlace(ProductPlaceDetailsModel chosenPlaceModel) {
    chosenPlaces.removeWhere(
      (item) =>
          item.productPlaceModel.productPlacesId ==
          chosenPlaceModel.productPlaceModel.productPlacesId,
    );
    emit(EditSellProductPlaceItem(
        id: chosenPlaceModel.productPlaceModel.productPlacesId!, isAdd: false));
  }

  void editProductPlace(ProductPlaceDetailsModel chosenPlaceModel) {
    chosenPlaces.any(
      (item) =>
          item.productPlaceModel.productPlacesId ==
          chosenPlaceModel.productPlaceModel.productPlacesId,
    )
        ? deleteProductPlace(chosenPlaceModel)
        : addProductPlace(chosenPlaceModel);
  }

  @override
  Future<void> close() {
    chosenPlaces.clear();
    return super.close();
  }
}
