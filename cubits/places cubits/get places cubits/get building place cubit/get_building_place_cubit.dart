import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/place%20repo/place_repo_imp.dart';

part 'get_building_place_state.dart';

class GetBuildingPlaceCubit extends SafeCubit<GetBuildingPlaceState> {
  GetBuildingPlaceCubit(this.placeRepoImpl) : super(GetBuildingPlaceInitial());
  PlaceRepoImpl placeRepoImpl;
  Future<void> getBuildingAndPlaces() async {
    emit(GetBuildingPlaceLoading());
    var result = await placeRepoImpl.getBuildingsAndPlaces();
    result.fold((failure) {
      emit(GetBuildingPlaceFailure(failure.errMessage));
    }, (_) {
      emit(GetBuildingPlaceSuccess());
    });
  }
}
