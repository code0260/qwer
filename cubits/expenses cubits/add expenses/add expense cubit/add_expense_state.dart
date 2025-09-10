part of 'add_expense_cubit.dart';

sealed class AddExpenseState extends Equatable {
  const AddExpenseState();

  @override
  List<Object> get props => [];
}

final class AddExpenseInitial extends AddExpenseState {}

class AddExpenseLoading extends AddExpenseState {}

class AddExpenseFailure extends AddExpenseState {
  final String errorMessage;

  const AddExpenseFailure(this.errorMessage);
}

class AddExpenseSuccess extends AddExpenseState {
  const AddExpenseSuccess();
}
