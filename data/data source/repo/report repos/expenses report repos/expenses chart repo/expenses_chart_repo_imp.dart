import 'package:almonazim/core/api/api_service.dart';
import 'package:almonazim/core/constant/app_links.dart';
import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/expenses%20report%20repos/expenses%20chart%20repo/expenses_chart_repo.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/report%20models/expenses%20report%20models/expense_pie_chart_model.dart';
import 'package:dartz/dartz.dart';

class ExpensesChartRepoImpl implements ExpensesChartRepo {
  final ApiService apiService;
  ExpensesChartRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<ExpensePieChartModel>>> getExpensePieChart(
      ExpenseInputModel expenseInputModel) async {
    final result = await apiService.post(
        formDataIsEnabled: true,
        url: AppLinks.expensesPieChartLink,
        data: expenseInputModel.toMap());

    return result.fold(
      (failure) => left(failure),
      (response) {
        List<ExpensePieChartModel> expenses = [];
        for (final expense in response["data"]) {
          expenses.add(ExpensePieChartModel.fromMap(expense));
        }
        return right(expenses);
      },
    );
  }
}
