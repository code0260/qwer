import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';

class EditBuyEditProductPlaceCubit extends SafeCubit<void> {
  EditBuyEditProductPlaceCubit() : super(null);
  PlaceModel placeModel = const PlaceModel();
  void editStoreProductPlace(int productsId) {
    int index = cartBuyEditHome
        .indexWhere((item) => item.productModel.productsId == productsId);
    cartBuyEditHome[index].placeModel = placeModel;
  }

  String? get validatedData {
    if (placeModel.placesBuildingsId == null) {
      return "الرجاء اخيار المبنى";
    } else if (placeModel.placesFloorNumber == null) {
      return "الرجاء اخيار الطابق";
    } else {
      return null;
    }
  }

  PlaceModel givePlaceData({
    int? placesId,
    int? placesBuildingsId,
    int? placesFloorNumber,
    String? placesRoomName,
    String? placesShelvesAlphabet,
  }) {
    placeModel = placeModel.copyWith(
      placesId: placesId ?? placeModel.placesId,
      placesBuildingsId: placesBuildingsId ?? placeModel.placesBuildingsId,
      placesFloorNumber: placesFloorNumber ?? placeModel.placesFloorNumber,
      placesRoomNumber: placesRoomName ?? placesRoomName,
      placesShelvesAlphabet:
          placesShelvesAlphabet ?? placeModel.placesShelvesAlphabet,
    );
    return placeModel;
  }
}
