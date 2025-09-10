part of 'add_payments_cubit.dart';

sealed class AddPaymentsState extends Equatable {
  const AddPaymentsState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class AddPaymentsInitial extends AddPaymentsState {}

class AddPaymentsLoading extends AddPaymentsState {}

class AddPaymentsFailure extends AddPaymentsState {
  final String errorMessage;

  const AddPaymentsFailure(this.errorMessage);
}

class AddPaymentsSuccess extends AddPaymentsState {}

class AddPaymentsCurrencyChanged extends AddPaymentsState {
  final int currencyId;

  const AddPaymentsCurrencyChanged({required this.currencyId});
  @override
  // TODO: implement props
  List<Object?> get props => [currencyId];
}

class AddPaymentsClientChanged extends AddPaymentsState {
  final int clientId;

  const AddPaymentsClientChanged({required this.clientId});
  @override
  // TODO: implement props
  List<Object?> get props => [clientId];
}
