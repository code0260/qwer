import 'package:almonazim/core/helper/functions/unit%20functions/convert_count.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/product%20movement%20repo/product_movement_repo_imp.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';
import 'package:almonazim/data/model/product%20movement/move_product_model.dart';
import 'package:equatable/equatable.dart';

part 'move_product_state.dart';

class MoveProductCubit extends SafeCubit<MoveProductState> {
  MoveProductCubit(this.productMovementRepoImpl) : super(MoveProductInitial());
  ProductMovementRepoImpl productMovementRepoImpl;
  MoveProductModel moveProductModel = MoveProductModel(
      newPlaceInputModel: const PlaceModel(),
      originalPlaceInputModel: const PlaceModel());
  Future<void> moveProduct() async {
    emit(MoveProductLoading());
    var result = await productMovementRepoImpl.moveProduct(moveProductModel);
    result.fold((failure) {
      emit(MoveProductFailure(failure.errMessage));
    }, (_) {
      emit(MoveProductSuccess());
    });
  }

  PlaceModel giveNewPlaceData({
    int? placesId,
    int? placesBuildingsId,
    int? placesFloorNumber,
    String? placesRoomName,
    String? placesShelvesAlphabet,
  }) {
    moveProductModel.newPlaceInputModel =
        moveProductModel.newPlaceInputModel.copyWith(
      placesId: placesId ?? moveProductModel.newPlaceInputModel.placesId,
      placesBuildingsId: placesBuildingsId ??
          moveProductModel.newPlaceInputModel.placesBuildingsId,
      placesFloorNumber: placesFloorNumber ??
          moveProductModel.newPlaceInputModel.placesFloorNumber,
      placesRoomNumber: placesRoomName ?? placesRoomName,
      placesShelvesAlphabet: placesShelvesAlphabet ??
          moveProductModel.newPlaceInputModel.placesShelvesAlphabet,
    );
    return moveProductModel.newPlaceInputModel;
  }

  PlaceModel giveOriginalPlaceData({
    int? placesId,
    int? placesBuildingsId,
    int? placesFloorNumber,
    String? placesRoomName,
    String? placesShelvesAlphabet,
  }) {
    moveProductModel.originalPlaceInputModel =
        moveProductModel.originalPlaceInputModel.copyWith(
      placesId: placesId ?? moveProductModel.originalPlaceInputModel.placesId,
      placesBuildingsId: placesBuildingsId ??
          moveProductModel.originalPlaceInputModel.placesBuildingsId,
      placesFloorNumber: placesFloorNumber ??
          moveProductModel.originalPlaceInputModel.placesFloorNumber,
      placesRoomNumber: placesRoomName ?? placesRoomName,
      placesShelvesAlphabet: placesShelvesAlphabet ??
          moveProductModel.originalPlaceInputModel.placesShelvesAlphabet,
    );
    return moveProductModel.originalPlaceInputModel;
  }

  String? get getMoveProductValidationMessage {
    if (moveProductModel.originalPlaceInputModel.placesBuildingsId == null) {
      return "الرجاء تحديد المبنى للموقع الأصلي";
    } else if (moveProductModel.originalPlaceInputModel.placesFloorNumber ==
        null) {
      return "الرجاء تحديد الطابق للموقع الأصلي";
    } else if (moveProductModel.newPlaceInputModel.placesBuildingsId == null) {
      return "الرجاء تحديد المبنى للموقع الجديد";
    } else if (moveProductModel.newPlaceInputModel.placesFloorNumber == null) {
      return "الرجاء تحديد الطابق للموقع الجديد";
    } else if (moveProductModel.count == null || moveProductModel.count! <= 0) {
      return "الرجاء إدخال الكمية بشكل صحيح";
    } else if (moveProductModel.unitId == null) {
      return "الرجاء اختيار الوحدة";
    } else if (moveProductModel.productsId == null) {
      return "الرجاء اختيار المنتج";
    } else if (convertCount(
            moveProductModel.productPlaceModel.productPlacesCount!,
            moveProductModel.productPlaceModel.productPlacesCountUnitId!,
            moveProductModel.unitId!) <
        moveProductModel.count!) {
      return 'لا يوجد كمية كافية عذراً';
    } else {
      return null;
    }
  }
}
