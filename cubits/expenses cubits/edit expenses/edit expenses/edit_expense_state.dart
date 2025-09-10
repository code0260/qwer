part of 'edit_expense_cubit.dart';

sealed class EditExpensesState extends Equatable {
  const EditExpensesState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class EditExpensesInitial extends EditExpensesState {}

class EditExpensesLoading extends EditExpensesState {}

class EditExpensesFailure extends EditExpensesState {
  final String errorMessage;

  const EditExpensesFailure(this.errorMessage);
}

class EditExpensesSuccess extends EditExpensesState {}

class EditExpenseCurrencyChanged extends EditExpensesState {
  final int currencyId;

  const EditExpenseCurrencyChanged({required this.currencyId});
  @override
  // TODO: implement props
  List<Object?> get props => [currencyId];
}
