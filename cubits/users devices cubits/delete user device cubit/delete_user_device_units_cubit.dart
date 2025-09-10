import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/user%20devices%20repo/user_devices_repo_imp.dart';
import 'package:equatable/equatable.dart';

part 'delete_user_device_state.dart';

class DeleteUserDeviceCubit extends SafeCubit<DeleteUserDeviceState> {
  DeleteUserDeviceCubit(this.unitRepo) : super(DeleteUserDeviceInitial());
  UserDeviceRepoImpl unitRepo;

  Future<void> deleteUserDevice(int userDeviceId) async {
    emit(DeleteUserDeviceLoading());
    var result = await unitRepo.deleteUserDeviceById(userDeviceId);
    result.fold((failure) {
      emit(DeleteUserDeviceFailure(failure.errMessage));
    }, (units) {
      emit(DeleteUserDeviceSuccess());
    });
  }
}
