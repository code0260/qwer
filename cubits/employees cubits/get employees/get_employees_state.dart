part of 'get_employees_cubit.dart';

sealed class GetEmployeesState extends Equatable {
  const GetEmployeesState();

  @override
  List<Object> get props => [];
}

final class GetEmployeesInitial extends GetEmployeesState {}

class GetEmployeesLoading extends GetEmployeesState {}

class GetEmployeesFailure extends GetEmployeesState {
  final String errorMessage;

  const GetEmployeesFailure(this.errorMessage);
}

class GetEmployeesSuccess extends GetEmployeesState {
  final List<EmployeeModel> employees;
  const GetEmployeesSuccess({
    required this.employees,
  });
}
