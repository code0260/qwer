part of 'get_employees_compensation_cubit.dart';

sealed class GetEmployeesCompensationState extends Equatable {
  const GetEmployeesCompensationState();

  @override
  List<Object> get props => [];
}

final class GetEmployeesCompensationInitial
    extends GetEmployeesCompensationState {}

class GetEmployeesCompensationLoading extends GetEmployeesCompensationState {}

class GetEmployeesCompensationFailure extends GetEmployeesCompensationState {
  final String errorMessage;

  const GetEmployeesCompensationFailure(this.errorMessage);
}

class GetEmployeesCompensationSuccess extends GetEmployeesCompensationState {
  final AllCompensationModel allCompensationModel;
  const GetEmployeesCompensationSuccess({
    required this.allCompensationModel,
  });
  @override
  // TODO: implement props
  List<Object> get props => [allCompensationModel];
}
