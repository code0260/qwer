part of 'add_employee_cubit.dart';

sealed class AddEmployeeState extends Equatable {
  const AddEmployeeState();

  @override
  List<Object> get props => [];
}

final class AddEmployeeInitial extends AddEmployeeState {}

class AddEmployeeLoading extends AddEmployeeState {}

class AddEmployeeFailure extends AddEmployeeState {
  final String errorMessage;

  const AddEmployeeFailure({required this.errorMessage});
}

class AddEmployeeSuccess extends AddEmployeeState {
  const AddEmployeeSuccess();
}
