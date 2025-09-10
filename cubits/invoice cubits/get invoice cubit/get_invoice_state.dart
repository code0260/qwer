part of 'get_invoice_cubit.dart';

sealed class GetInvoiceState extends Equatable {
  const GetInvoiceState();

  @override
  List<Object> get props => [];
}

final class GetInvoiceInitial extends GetInvoiceState {}

class GetInvoiceLoading extends GetInvoiceState {}

class GetInvoiceFailure extends GetInvoiceState {
  final String errorMessage;

  const GetInvoiceFailure(this.errorMessage);
}

class GetInvoiceSuccess extends GetInvoiceState {
  final List<InvoiceModel> invoices;
  const GetInvoiceSuccess({
    required this.invoices,
  });
  @override
  // TODO: implement props
  List<Object> get props => [invoices];
}
