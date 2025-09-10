import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/business%20models/add_business_model.dart';
import 'package:almonazim/data/model/user%20models/user_input_model.dart';
import 'package:almonazim/data/model/user%20models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepo {
  Future<Either<Failure, void>> enterDemoAccount(UserInputModel userInputModel);
  Future<Either<Failure, void>> addUser(UserInputModel userInputModel);
  Future<Either<Failure, void>> finishDemoAccount(
      AddBusinessModel addBusinessModel, int baseCurrencyId, String? imagePath);

  Future<Either<Failure, List<UserModel>>> getUsers();
  Future<Either<Failure, void>> editUser(UserInputModel userInputModel);
  Future<Either<Failure, void>> logout();
}
