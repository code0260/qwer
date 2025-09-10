part of 'edit_employee_cubit.dart';

sealed class EditEmployeeState extends Equatable {
  const EditEmployeeState();

  @override
  List<Object> get props => [];
}

final class EditEmployeeInitial extends EditEmployeeState {}

class EditEmployeeLoading extends EditEmployeeState {}

class EditEmployeeFailure extends EditEmployeeState {
  final String errorMessage;

  const EditEmployeeFailure({required this.errorMessage});
}

class EditEmployeeSuccess extends EditEmployeeState {
  const EditEmployeeSuccess();
}
