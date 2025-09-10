part of 'get_debt_payments_cubit.dart';

sealed class GetDebtPaymentsState extends Equatable {
  const GetDebtPaymentsState();

  @override
  List<Object> get props => [];
}

final class GetDebtPaymentsInitial extends GetDebtPaymentsState {}

class GetDebtPaymentsLoading extends GetDebtPaymentsState {}

class GetDebtPaymentsFailure extends GetDebtPaymentsState {
  final String errorMessage;

  const GetDebtPaymentsFailure(this.errorMessage);
}

class GetDebtPaymentsSuccess extends GetDebtPaymentsState {
  final List<GetDebtPaymentModel> debtPayments;
  const GetDebtPaymentsSuccess({
    required this.debtPayments,
  });
  @override
  // TODO: implement props
  List<Object> get props => [debtPayments];
}
