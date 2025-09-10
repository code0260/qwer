part of 'revenues_pie_chart_cubit.dart';

sealed class RevenuesPieChartState extends Equatable {
  const RevenuesPieChartState();

  @override
  List<Object> get props => [];
}

final class RevenuesPieChartInitial extends RevenuesPieChartState {}

class RevenuesPieChartLoading extends RevenuesPieChartState {}

class RevenuesPieChartFailure extends RevenuesPieChartState {
  final String errorMessage;

  const RevenuesPieChartFailure(this.errorMessage);
}

class RevenuesPieChartSuccess extends RevenuesPieChartState {
  final List<RevenuePieChartModel> revenueChart;

  const RevenuesPieChartSuccess({required this.revenueChart});
}
