import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/account%20models/account_input_model.dart';
import 'package:almonazim/data/model/account%20models/trial_balance_model.dart';
import 'package:dartz/dartz.dart';

abstract class TrialBalanceRepo {
  Future<Either<Failure, double>> getAccountAmount(
      AccountInputModel accountInputModel);
  Future<Either<Failure, List<TrialBalanceModel>>> getMoreAccountsAmount(
      List<int> accountsId);
}
