part of 'get_employees_departments_cubit.dart';

sealed class GetEmployeesDepartmentsState extends Equatable {
  const GetEmployeesDepartmentsState();

  @override
  List<Object> get props => [];
}

final class GetEmployeesDepartmentsInitial
    extends GetEmployeesDepartmentsState {}

class GetEmployeesDepartmentsLoading extends GetEmployeesDepartmentsState {}

class GetEmployeesDepartmentsFailure extends GetEmployeesDepartmentsState {
  final String errorMessage;

  const GetEmployeesDepartmentsFailure(this.errorMessage);
}

class GetEmployeesDepartmentsSuccess extends GetEmployeesDepartmentsState {
  final List<EmployeesDepartmentsModel> employeesDepartments;
  const GetEmployeesDepartmentsSuccess({
    required this.employeesDepartments,
  });
}
