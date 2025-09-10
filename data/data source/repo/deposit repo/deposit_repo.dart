import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/deposit%20models/deposit_input_model.dart';
import 'package:almonazim/data/model/deposit%20models/deposit_model.dart';
import 'package:dartz/dartz.dart';

abstract class DepositRepo {
  Future<Either<Failure, List<DepositModel>>> getDeposits(
      DepositInputModel depositInputModel);

  Future<Either<Failure, void>> addDeposit(DepositInputModel depositInputModel);
  Future<Either<Failure, void>> deleteDeposit(
      DepositInputModel depositInputModel);
}
