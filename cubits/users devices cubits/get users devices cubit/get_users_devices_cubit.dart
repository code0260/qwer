import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/user%20devices%20repo/user_devices_repo_imp.dart';
import 'package:almonazim/data/model/user%20device%20models/user_device_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'get_users_devices_state.dart';

class GetUsersDevicesCubit extends SafeCubit<GetUsersDevicesState> {
  GetUsersDevicesCubit(this.userRepo) : super(GetUsersDevicesInitial());
  UserDeviceRepoImpl userRepo;

  Future<void> getUsersDevices(int userId) async {
    emit(GetUsersDevicesLoading());
    Either<Failure, List<UserDeviceModel>> result =
        await userRepo.getUsersDevices(userId);
    result.fold((failure) {
      emit(GetUsersDevicesFailure(failure.errMessage));
    }, (users) {
      emit(GetUsersDevicesSuccess(users: users));
    });
  }
}
