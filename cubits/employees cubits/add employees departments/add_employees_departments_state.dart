part of 'add_employees_departments_cubit.dart';

sealed class AddEmployeesDepartmentsState extends Equatable {
  const AddEmployeesDepartmentsState();

  @override
  List<Object> get props => [];
}

final class AddEmployeesDepartmentsInitial
    extends AddEmployeesDepartmentsState {}

class AddEmployeesDepartmentsLoading extends AddEmployeesDepartmentsState {}

class AddEmployeesDepartmentsFailure extends AddEmployeesDepartmentsState {
  final String errorMessage;

  const AddEmployeesDepartmentsFailure(this.errorMessage);
}

class AddEmployeesDepartmentsSuccess extends AddEmployeesDepartmentsState {}
