import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/debt%20models/debt_input_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:almonazim/data/model/filter_model.dart';
import 'package:dartz/dartz.dart';

abstract class DebtsRepo {
  Future<Either<Failure, List<DebtModel>>> getDebts(FilterModel filterModel);
  Future<Either<Failure, void>> editDebts(EditDebtModel editDebtModel);
  Future<Either<Failure, void>> editDebtCurrency(EditDebtModel editDebtModel);
  Future<Either<Failure, List<DebtModel>>> refreshDebts(
      FilterModel filterModel);
  Future<Either<Failure, void>> killDebt(EditDebtModel editDebtModel);
  Future<Either<Failure, void>> forgiveDebt(EditDebtModel editDebtModel);
  Future<Either<Failure, void>> unForgiveDebt(EditDebtModel editDebtModel);
  Future<Either<Failure, void>> resuscitateDebt(EditDebtModel editDebtModel);
  Future<Either<Failure, void>> importDebts(String filePath);
  Future<Either<Failure, void>> addDebt(DebtInputModel debtInputModel);
}
