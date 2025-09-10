part of 'edit_debt_currency_cubit.dart';

sealed class EditDebtCurrencyState extends Equatable {
  const EditDebtCurrencyState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class EditDebtCurrencyInitial extends EditDebtCurrencyState {}

class EditDebtCurrencyLoading extends EditDebtCurrencyState {}

class EditDebtCurrencyFailure extends EditDebtCurrencyState {
  final String errorMessage;

  const EditDebtCurrencyFailure(this.errorMessage);
}

class EditDebtCurrencySuccess extends EditDebtCurrencyState {}
