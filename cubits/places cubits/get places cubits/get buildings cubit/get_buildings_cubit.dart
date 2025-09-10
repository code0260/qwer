import 'package:dartz/dartz.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/locale/sqflite/store_buildings.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:almonazim/data/data%20source/repo/place%20repo/place_repo_imp.dart';
import 'package:almonazim/data/model/place%20models/building_model.dart';

part 'get_buildings_state.dart';

class GetBuildingsCubit extends SafeCubit<GetBuildingsState> {
  GetBuildingsCubit(this.placeRepoImpl) : super(GetBuildingsInitial());
  PlaceRepoImpl placeRepoImpl;

  Future<void> getBuildings() async {
    emit(GetBuildingsLoading());
    Either<Failure, List<BuildingModel>> result;
    if (StoreWorkOffline.getWorkOffline() == true) {
      result = await StoreBuildings.getBuildings();
    } else {
      result = await placeRepoImpl.getBuildings();
    }
    result.fold((failure) {
      emit(GetBuildingsFailure(failure.errMessage));
    }, (buildings) {
      emit(GetBuildingSuccess(buildings: buildings));
    });
  }
}
