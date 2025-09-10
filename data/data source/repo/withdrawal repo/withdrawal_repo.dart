import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/withdrawal%20models/withdrawal_input_model.dart';
import 'package:almonazim/data/model/withdrawal%20models/withdrawal_model.dart';
import 'package:dartz/dartz.dart';

abstract class WithdrawalRepo {
  Future<Either<Failure, List<WithdrawalModel>>> getWithdrawals(
      WithdrawalInputModel withdrawalInputModel);

  Future<Either<Failure, void>> addWithdrawal(
      WithdrawalInputModel withdrawalInputModel);
  Future<Either<Failure, void>> deleteWithdrawal(
      WithdrawalInputModel withdrawalInputModel);
}
