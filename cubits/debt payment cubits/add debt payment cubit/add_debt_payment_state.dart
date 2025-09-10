part of 'add_debt_payment_cubit.dart';

sealed class AddDebtPaymentState extends Equatable {
  const AddDebtPaymentState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class AddDebtPaymentInitial extends AddDebtPaymentState {}

class AddDebtPaymentLoading extends AddDebtPaymentState {}

class AddDebtPaymentFailure extends AddDebtPaymentState {
  final String errorMessage;

  const AddDebtPaymentFailure(this.errorMessage);
}

class AddDebtPaymentSuccess extends AddDebtPaymentState {}

class AddDebtPaymentCurrencyChanged extends AddDebtPaymentState {
  final int currencyId;

  const AddDebtPaymentCurrencyChanged({required this.currencyId});
  @override
  // TODO: implement props
  List<Object?> get props => [currencyId];
}
