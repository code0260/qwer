import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20place%20repo/product_place_repo.dart';
import 'package:almonazim/data/model/place%20models/place_input_model.dart';
import 'package:almonazim/data/model/place%20models/product_place_details_input_model.dart';
import 'package:almonazim/data/model/place%20models/product_place_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_product_place_state.dart';

class AddProductPlaceCubit extends SafeCubit<AddProductPlaceState> {
  AddProductPlaceCubit(this.productPlaceRepo) : super(AddProductPlaceInitial());
  ProductPlaceRepo productPlaceRepo;
  ProductPlaceDetailsInputModel productPlaceDetailsInputModel =
      ProductPlaceDetailsInputModel(
          placeModel: PlaceInputModel(),
          productPlaceModel: ProductPlaceInputModel());
  Future<void> addProductPlace() async {
    emit(AddProductPlaceLoading());
    var result =
        await productPlaceRepo.addProductPlace(productPlaceDetailsInputModel);
    result.fold((failure) {
      emit(AddProductPlaceFailure(failure.errMessage));
    }, (_) {
      emit(const AddProductPlaceSuccess());
    });
  }

  String? get validateDataMessage {
    if (productPlaceDetailsInputModel
            .productPlaceModel.productPlacesProductsId ==
        null) {
      return "الرجاء اختيار المنتج";
    } else if (productPlaceDetailsInputModel
                .productPlaceModel.productPlacesCount ==
            null ||
        productPlaceDetailsInputModel.productPlaceModel.productPlacesCount! <=
            0) {
      return "الرجاء إدخال كمية المنتج بشكل صحيح";
    } else if (productPlaceDetailsInputModel
            .productPlaceModel.productPlacesCountUnitId ==
        null) {
      return "الرجاء اختيار وحدة قياس الكمية";
    } else if (productPlaceDetailsInputModel.placeModel.placesBuildingsId ==
        null) {
      return "الرجاء اخيار المبنى";
    } else if (productPlaceDetailsInputModel.placeModel.placesFloorNumber ==
        null) {
      return "الرجاء اخيار الطابق";
    } else {
      return null;
    }
  }
}
