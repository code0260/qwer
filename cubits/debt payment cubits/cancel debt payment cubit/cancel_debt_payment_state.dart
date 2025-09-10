part of 'cancel_debt_payment_cubit.dart';

sealed class CancelDebtPaymentState extends Equatable {
  const CancelDebtPaymentState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class CancelDebtPaymentInitial extends CancelDebtPaymentState {}

class CancelDebtPaymentLoading extends CancelDebtPaymentState {}

class CancelDebtPaymentFailure extends CancelDebtPaymentState {
  final String errorMessage;

  const CancelDebtPaymentFailure(this.errorMessage);
}

class CancelDebtPaymentSuccess extends CancelDebtPaymentState {}

class CancelDebtPaymentCurrencyChanged extends CancelDebtPaymentState {
  final int currencyId;

  const CancelDebtPaymentCurrencyChanged({required this.currencyId});
  @override
  // TODO: implement props
  List<Object?> get props => [currencyId];
}
