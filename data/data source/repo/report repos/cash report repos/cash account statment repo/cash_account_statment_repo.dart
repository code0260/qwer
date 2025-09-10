import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/cash%20models/cash_input_model.dart';
import 'package:almonazim/data/model/report%20models/cash%20report%20models/cash_account_statement_model.dart';
import 'package:dartz/dartz.dart';

abstract class CashAccountStatementRepo {
  Future<Either<Failure, CashAccountStatementModel>> getCashAccountStatements(
      CashInputModel cashModel);
}
