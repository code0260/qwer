part of 'get_paid_salaries_cubit.dart';

sealed class GetPaidSalariesState extends Equatable {
  const GetPaidSalariesState();

  @override
  List<Object> get props => [];
}

final class GetPaidSalariesInitial extends GetPaidSalariesState {}

class GetPaidSalariesLoading extends GetPaidSalariesState {}

class GetPaidSalariesFailure extends GetPaidSalariesState {
  final String errorMessage;

  const GetPaidSalariesFailure(this.errorMessage);
}

class GetPaidSalariesSuccess extends GetPaidSalariesState {
  final List<SalarySlipModel> salarySlips;
  const GetPaidSalariesSuccess({
    required this.salarySlips,
  });
  @override
  // TODO: implement props
  List<Object> get props => [salarySlips];
}
