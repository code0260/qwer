part of 'get_employees_vacation_cubit.dart';

sealed class GetEmployeesVacationState extends Equatable {
  const GetEmployeesVacationState();

  @override
  List<Object> get props => [];
}

final class GetEmployeesVacationInitial extends GetEmployeesVacationState {}

class GetEmployeesVacationLoading extends GetEmployeesVacationState {}

class GetEmployeesVacationFailure extends GetEmployeesVacationState {
  final String errorMessage;

  const GetEmployeesVacationFailure(this.errorMessage);
}

class GetEmployeesVacationSuccess extends GetEmployeesVacationState {
  final List<VacationModel> vacations;
  const GetEmployeesVacationSuccess({
    required this.vacations,
  });
  @override
  // TODO: implement props
  List<Object> get props => [vacations];
}
