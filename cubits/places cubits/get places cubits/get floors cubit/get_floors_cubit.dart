import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/place%20repo/place_repo_imp.dart';
import 'package:almonazim/data/model/place%20models/floor_model.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';

part 'get_floors_state.dart';

class GetFloorsCubit extends SafeCubit<GetFloorsState> {
  GetFloorsCubit(this.placeRepoImpl) : super(GetFloorsInitial());
  PlaceRepoImpl placeRepoImpl;
  Future<void> getFloors(PlaceModel placeModel) async {
    emit(GetFloorsLoading());
    var result = await placeRepoImpl.getFloors(placeModel);
    result.fold((failure) {
      emit(GetFloorsFailure(failure.errMessage));
    }, (floors) {
      emit(GetFloorsSuccess(floors: floors));
    });
  }
}
