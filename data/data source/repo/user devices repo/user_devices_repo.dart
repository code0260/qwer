import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/user%20device%20models/user_device_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserDeviceRepo {
  Future<Either<Failure, List<UserDeviceModel>>> getUsersDevices(int usersId);
  Future<Either<Failure, void>> deleteUserDeviceById(int userDeviceId);
}
