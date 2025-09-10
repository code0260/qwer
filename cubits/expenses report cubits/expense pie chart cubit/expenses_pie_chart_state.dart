part of 'expenses_pie_chart_cubit.dart';

sealed class ExpensesPieChartState extends Equatable {
  const ExpensesPieChartState();

  @override
  List<Object> get props => [];
}

final class ExpensesPieChartInitial extends ExpensesPieChartState {}

class ExpensesPieChartLoading extends ExpensesPieChartState {}

class ExpensesPieChartFailure extends ExpensesPieChartState {
  final String errorMessage;

  const ExpensesPieChartFailure(this.errorMessage);
}

class ExpensesPieChartSuccess extends ExpensesPieChartState {
  final List<ExpensePieChartModel> expenseChart;

  const ExpensesPieChartSuccess({required this.expenseChart});
}
