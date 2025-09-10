part of 'get_unpaid_salaries_cubit.dart';

sealed class GetUnpaidSalariesState extends Equatable {
  const GetUnpaidSalariesState();

  @override
  List<Object> get props => [];
}

final class GetUnpaidSalariesInitial extends GetUnpaidSalariesState {}

class GetUnpaidSalariesLoading extends GetUnpaidSalariesState {}

class GetUnpaidSalariesFailure extends GetUnpaidSalariesState {
  final String errorMessage;

  const GetUnpaidSalariesFailure(this.errorMessage);
}

class GetUnpaidSalariesSuccess extends GetUnpaidSalariesState {
  final List<SalarySlipEmployeeModel> salarySlipsEmployee;
  const GetUnpaidSalariesSuccess({
    required this.salarySlipsEmployee,
  });
  @override
  // TODO: implement props
  List<Object> get props => [salarySlipsEmployee];
}
