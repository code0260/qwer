part of 'add_salary_cubit.dart';

sealed class AddSalaryState extends Equatable {
  const AddSalaryState();

  @override
  List<Object> get props => [];
}

final class AddSalaryInitial extends AddSalaryState {}

class AddSalaryLoading extends AddSalaryState {}

class AddSalaryFailure extends AddSalaryState {
  final String errorMessage;

  const AddSalaryFailure(this.errorMessage);
}

class AddSalarySuccess extends AddSalaryState {
  const AddSalarySuccess();
}
