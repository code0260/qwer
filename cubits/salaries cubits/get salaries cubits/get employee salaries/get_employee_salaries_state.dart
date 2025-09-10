part of 'get_employee_salaries_cubit.dart';

sealed class GetEmployeeSalariesState extends Equatable {
  const GetEmployeeSalariesState();

  @override
  List<Object> get props => [];
}

final class GetEmployeeSalariesInitial extends GetEmployeeSalariesState {}

class GetEmployeeSalariesLoading extends GetEmployeeSalariesState {}

class GetEmployeeSalariesFailure extends GetEmployeeSalariesState {
  final String errorMessage;

  const GetEmployeeSalariesFailure(this.errorMessage);
}

class GetEmployeeSalariesSuccess extends GetEmployeeSalariesState {
  final List<SalaryModel> salaries;
  const GetEmployeeSalariesSuccess({
    required this.salaries,
  });
}
