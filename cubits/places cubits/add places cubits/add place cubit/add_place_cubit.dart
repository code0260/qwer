import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/place%20repo/place_repo_imp.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';
import 'package:equatable/equatable.dart';

part 'add_place_state.dart';

class AddPlaceCubit extends SafeCubit<AddPlaceState> {
  AddPlaceCubit(this.placeRepo) : super(AddPlaceInitial());
  PlaceRepoImpl placeRepo;
  PlaceModel placeModel = const PlaceModel();

  Future<void> addPlace() async {
    emit(AddPlaceLoading());
    var result = await placeRepo.addPlace(placeModel);
    result.fold((failure) {
      emit(AddPlaceFailure(failure.errMessage));
    }, (placeId) {
      givePlaceData(placesId: placeId);
      emit(AddPlaceSuccess());
    });
  }

  String? get validatedData {
    if (placeModel.placesBuildingsId == null) {
      return "الرجاء اخيار المبنى";
    } else if (placeModel.placesFloorNumber == null) {
      return "الرجاء اخيار الطابق";
    } else if (placeModel.placesRoomName == null) {
      return "الرجاء اخيار الغرفة أو القسم";
    } else if (placeModel.placesShelvesAlphabet == null) {
      return "الرجاء اخيار الرف";
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
