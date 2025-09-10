part of 'add_rent_prepaid_expense_cubit.dart';

sealed class AddRentPrepaidExpenseState extends Equatable {
  const AddRentPrepaidExpenseState();

  @override
  List<Object> get props => [];
}

final class AddRentPrepaidExpenseInitial extends AddRentPrepaidExpenseState {}

class AddRentPrepaidExpenseLoading extends AddRentPrepaidExpenseState {}

class AddRentPrepaidExpenseFailure extends AddRentPrepaidExpenseState {
  final String errorMessage;

  const AddRentPrepaidExpenseFailure(this.errorMessage);
}

class AddRentPrepaidExpenseSuccess extends AddRentPrepaidExpenseState {
  const AddRentPrepaidExpenseSuccess();
}
