part of 'delete_expense_cubit.dart';

sealed class DeleteExpenseState extends Equatable {
  const DeleteExpenseState();

  @override
  List<Object> get props => [];
}

final class DeleteExpenseInitial extends DeleteExpenseState {}

class DeleteExpenseLoading extends DeleteExpenseState {}

class DeleteExpenseFailure extends DeleteExpenseState {
  final String errorMessage;

  const DeleteExpenseFailure({required this.errorMessage});
}

class DeleteExpenseSuccess extends DeleteExpenseState {}
