part of 'add_salary_slip_cubit.dart';

sealed class AddSalarySlipState extends Equatable {
  const AddSalarySlipState();

  @override
  List<Object> get props => [];
}

final class AddSalarySlipInitial extends AddSalarySlipState {}

class AddSalarySlipLoading extends AddSalarySlipState {}

class AddSalarySlipFailure extends AddSalarySlipState {
  final String errorMessage;

  const AddSalarySlipFailure(this.errorMessage);
}

class AddSalarySlipSuccess extends AddSalarySlipState {
  const AddSalarySlipSuccess();
}
