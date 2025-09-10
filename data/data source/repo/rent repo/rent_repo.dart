import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/expenses%20models/rent_prepaid_expense_input_model.dart';
import 'package:almonazim/data/model/expenses%20models/rent_prepaid_expense_model.dart';
import 'package:almonazim/data/model/revenues%20models/rent_prepaid_revenue_input_model.dart';
import 'package:almonazim/data/model/revenues%20models/rent_prepaid_revenue_model.dart';
import 'package:dartz/dartz.dart';

abstract class RentRepo {
  //$ get
  Future<Either<Failure, List<RentPrepaidExpenseModel>>> getExpenseRents(
      RentPrepaidExpenseInputModel rentPrepaidExpenseInputModel);
  //$ get
  Future<Either<Failure, List<RentPrepaidRevenueModel>>> getRevenueRents(
      RentPrepaidRevenueInputModel rentPrepaidRevenueInputModel);
}
