part of 'import_expenses_cubit.dart';

sealed class ImportExpensesState extends Equatable {
  const ImportExpensesState();

  @override
  List<Object> get props => [];
}

final class ImportExpensesInitial extends ImportExpensesState {}

class ImportExpensesLoading extends ImportExpensesState {}

class ImportExpensesFailure extends ImportExpensesState {
  final String errorMessage;

  const ImportExpensesFailure({required this.errorMessage});
}

class ImportExpensesSuccess extends ImportExpensesState {}
