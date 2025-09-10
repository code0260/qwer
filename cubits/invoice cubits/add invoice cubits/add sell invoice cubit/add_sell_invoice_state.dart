part of 'add_sell_invoice_cubit.dart';

sealed class AddSellInvoiceState extends Equatable {
  const AddSellInvoiceState();

  @override
  List<Object> get props => [];
}

final class AddSellInvoiceInitial extends AddSellInvoiceState {}

class AddSellInvoiceLoading extends AddSellInvoiceState {}

class AddSellInvoiceFailure extends AddSellInvoiceState {
  final String errorMessage;

  const AddSellInvoiceFailure({required this.errorMessage});
}

class AddSellInvoiceSuccess extends AddSellInvoiceState {
  final int invoiceId;

  const AddSellInvoiceSuccess({required this.invoiceId});
}
