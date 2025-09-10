import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/debt%20models/add_payments_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_payment_input_model.dart';
import 'package:almonazim/data/model/debt%20models/get_debt_payment_model.dart';
import 'package:almonazim/data/model/filter_model.dart';
import 'package:dartz/dartz.dart';

abstract class DebtPaymentRepo {
  Future<Either<Failure, List<GetDebtPaymentModel>>> getDebtPayments(
      FilterModel filterModel);
  Future<Either<Failure, void>> addDebtPayment(
      DebtPaymentInputModel debtPaymentInputModel, DebtModel debtModel);
  Future<Either<Failure, void>> addPayments(AddPaymentsModel addPaymentsModel);
  Future<Either<Failure, void>> cancelDebtPayment(
      DebtPaymentInputModel debtPaymentInputModel, DebtModel debtModel);
}
