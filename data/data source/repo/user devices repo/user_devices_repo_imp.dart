import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/user%20devices%20repo/user_devices_repo.dart';
import 'package:almonazim/data/model/user%20device%20models/user_device_model.dart';
import 'package:dartz/dartz.dart';

class UserDeviceRepoImpl implements UserDeviceRepo {
  ApiService apiService;
  UserDeviceRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<UserDeviceModel>>> getUsersDevices(
      int usersId) async {
    final result = await apiService
        .post(data: {'users_id': usersId}, url: AppLinks.getUsersDevicesLink);

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<UserDeviceModel> usersDevicesLocale = [];
        for (final user in response["data"]) {
          usersDevicesLocale.add(UserDeviceModel.fromJson(user));
        }
        return right(usersDevicesLocale);
      },
    );
  }

  @override
  Future<Either<Failure, void>> deleteUserDeviceById(int userDeviceId) async {
    final requestData = {
      "users_devices_id": userDeviceId,
    };

    final result = await apiService.post(
      url: AppLinks.deleteUsersDevicesByIdLink,
      data: requestData,
    );

    return result.fold(
      (failure) => left(failure),
      (response) {
        return right(null);
      },
    );
  }
}
