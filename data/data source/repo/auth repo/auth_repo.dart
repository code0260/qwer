import 'package:dartz/dartz.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/auth models/login_request_model.dart';

import '../../../model/user models/store_user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> login(LoginRequestModel loginRequest);
  Future<Either<Failure, StoreUserModel>> getProfile();

}
