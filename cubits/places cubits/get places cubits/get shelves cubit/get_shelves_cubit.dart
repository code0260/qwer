import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/place%20repo/place_repo_imp.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';
import 'package:almonazim/data/model/place%20models/shelve_model.dart';

part 'get_shelves_state.dart';

class GetShelvesCubit extends SafeCubit<GetShelvesState> {
  GetShelvesCubit(this.placeRepoImpl) : super(GetShelvesInitial());
  PlaceRepoImpl placeRepoImpl;
  Future<void> getShelves(PlaceModel placeModel) async {
    emit(GetShelvesLoading());
    var result = await placeRepoImpl.getShelves(placeModel);
    result.fold((failure) {
      emit(GetShelvesFailure(failure.errMessage));
    }, (shelves) {
      emit(GetShelvesSuccess(shelves: shelves));
    });
  }

  void refresh() {
    emit(GetShelvesInitial());
  }
}
