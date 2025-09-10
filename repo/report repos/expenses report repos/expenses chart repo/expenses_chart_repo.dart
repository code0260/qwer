import 'package:almonazim/core/errors/failures.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/report%20models/expenses%20report%20models/expense_pie_chart_model.dart';
import 'package:dartz/dartz.dart';

abstract class ExpensesChartRepo {
  Future<Either<Failure, List<ExpensePieChartModel>>> getExpensePieChart(
      ExpenseInputModel expenseInputModel);
}
