import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/rent%20repo/rent_repo.dart';
import 'package:almonazim/data/model/expenses%20models/rent_prepaid_expense_input_model.dart';
import 'package:almonazim/data/model/expenses%20models/rent_prepaid_expense_model.dart';
import 'package:almonazim/data/model/revenues%20models/rent_prepaid_revenue_input_model.dart';
import 'package:almonazim/data/model/revenues%20models/rent_prepaid_revenue_model.dart';
import 'package:dartz/dartz.dart';

class RentRepoImpl implements RentRepo {
  final ApiService apiService;
  RentRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<RentPrepaidExpenseModel>>> getExpenseRents(
      RentPrepaidExpenseInputModel rentPrepaidExpenseInputModel) async {
    final result = await apiService.post(
        url: AppLinks.getRentPrepaidExpensesLink,
        formDataIsEnabled: false,
        data: rentPrepaidExpenseInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<RentPrepaidExpenseModel> rents = [];
        for (final expense in response["data"]) {
          rents.add(RentPrepaidExpenseModel.fromJson(expense));
        }

        return right(rents);
      },
    );
  }

  @override
  Future<Either<Failure, List<RentPrepaidRevenueModel>>> getRevenueRents(
      RentPrepaidRevenueInputModel rentPrepaidRevenueInputModel) async {
    final result = await apiService.post(
        url: AppLinks.getRentPrepaidRevenuesLink,
        formDataIsEnabled: false,
        data: rentPrepaidRevenueInputModel.toJson());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<RentPrepaidRevenueModel> rents = [];
        for (final expense in response["data"]) {
          rents.add(RentPrepaidRevenueModel.fromJson(expense));
        }

        return right(rents);
      },
    );
  }
}
