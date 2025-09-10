part of 'import_rent_prepaid_expenses_cubit.dart';

sealed class ImportRentPrepaidExpensesState extends Equatable {
  const ImportRentPrepaidExpensesState();

  @override
  List<Object> get props => [];
}

final class ImportRentPrepaidExpensesInitial
    extends ImportRentPrepaidExpensesState {}

class ImportRentPrepaidExpensesLoading extends ImportRentPrepaidExpensesState {}

class ImportRentPrepaidExpensesFailure extends ImportRentPrepaidExpensesState {
  final String errorMessage;

  const ImportRentPrepaidExpensesFailure({required this.errorMessage});
}

class ImportRentPrepaidExpensesSuccess extends ImportRentPrepaidExpensesState {}
