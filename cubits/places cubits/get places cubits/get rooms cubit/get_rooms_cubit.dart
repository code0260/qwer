import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/place%20repo/place_repo_imp.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';
import 'package:almonazim/data/model/place%20models/room_model.dart';

part 'get_rooms_state.dart';

class GetRoomsCubit extends SafeCubit<GetRoomsState> {
  GetRoomsCubit(this.placeRepoImpl) : super(GetRoomsInitial());
  PlaceRepoImpl placeRepoImpl;
  Future<void> getRooms(PlaceModel placeModel) async {
    emit(GetRoomsLoading());
    var result = await placeRepoImpl.getRooms(placeModel);
    result.fold((failure) {
      emit(GetRoomsFailure(failure.errMessage));
    }, (rooms) {
      emit(GetRoomsSuccess(rooms: rooms));
    });
  }

  void refresh() {
    emit(GetRoomsInitial());
  }
}
