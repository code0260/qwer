part of 'invoice_profit_cubit.dart';

sealed class InvoiceProfitState extends Equatable {
  const InvoiceProfitState();

  @override
  List<Object> get props => [];
}

final class InvoiceProfitInitial extends InvoiceProfitState {}

class InvoiceProfitLoading extends InvoiceProfitState {}

class InvoiceProfitFailure extends InvoiceProfitState {
  final String errorMessage;

  const InvoiceProfitFailure(this.errorMessage);
}

class InvoiceProfitSuccess extends InvoiceProfitState {
  final AllInvoicesProfitModel allInvoicesProfitModel;

  const InvoiceProfitSuccess({required this.allInvoicesProfitModel});
}
