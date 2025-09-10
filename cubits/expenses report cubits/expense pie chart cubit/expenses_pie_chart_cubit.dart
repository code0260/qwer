import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/report%20repos/expenses%20report%20repos/expenses%20chart%20repo/expenses_chart_repo.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/report%20models/expenses%20report%20models/expense_pie_chart_model.dart';
import 'package:equatable/equatable.dart';

part 'expenses_pie_chart_state.dart';

class ExpensesPieChartCubit extends SafeCubit<ExpensesPieChartState> {
  ExpensesPieChartCubit(this.expenseChartRepo)
      : super(ExpensesPieChartInitial());
  ExpensesChartRepo expenseChartRepo;
  PeriodType periodType = PeriodType.month;
  ExpenseInputModel expenseInputModel = ExpenseInputModel(
      startDate: DateTime.now().subtract(const Duration(days: 30)));
  Future<void> getExpensesPieChart() async {
    emit(ExpensesPieChartLoading());
    var result = await expenseChartRepo.getExpensePieChart(expenseInputModel);
    result.fold((failure) {
      emit(ExpensesPieChartFailure(failure.errMessage));
    }, (expenses) {
      emit(ExpensesPieChartSuccess(expenseChart: expenses));
    });
  }

  void setStartDateBasedOnPeriodType() {
    if (periodType == PeriodType.day) {
      expenseInputModel.startDate =
          DateTime.now().subtract(const Duration(days: 1));
    } else if (periodType == PeriodType.week) {
      expenseInputModel.startDate =
          DateTime.now().subtract(const Duration(days: 7));
    } else if (periodType == PeriodType.month) {
      expenseInputModel.startDate =
          DateTime.now().subtract(const Duration(days: 30));
    }
  }
}
