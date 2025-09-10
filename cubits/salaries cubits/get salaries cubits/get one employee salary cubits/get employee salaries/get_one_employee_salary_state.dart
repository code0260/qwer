part of 'get_one_employee_salary_cubit.dart';

sealed class GetOneEmployeeSalaryState extends Equatable {
  const GetOneEmployeeSalaryState();

  @override
  List<Object> get props => [];
}

final class GetOneEmployeeSalaryInitial extends GetOneEmployeeSalaryState {}

class GetOneEmployeeSalaryLoading extends GetOneEmployeeSalaryState {}

class GetOneEmployeeSalaryFailure extends GetOneEmployeeSalaryState {
  final String errorMessage;

  const GetOneEmployeeSalaryFailure(this.errorMessage);
}

class GetOneEmployeeSalarySuccess extends GetOneEmployeeSalaryState {
  final SalaryModel salaryModel;
  const GetOneEmployeeSalarySuccess({
    required this.salaryModel,
  });
}
