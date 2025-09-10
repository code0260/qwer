part of 'get_draft_sell_invoice_cubit.dart';

sealed class GetDraftSellInvoicesState extends Equatable {
  const GetDraftSellInvoicesState();

  @override
  List<Object> get props => [];
}

final class GetDraftSellInvoicesInitial extends GetDraftSellInvoicesState {}

class GetDraftSellInvoicesLoading extends GetDraftSellInvoicesState {}

class GetDraftSellInvoicesFailure extends GetDraftSellInvoicesState {
  final String errorMessage;

  const GetDraftSellInvoicesFailure(this.errorMessage);
}

class GetDraftSellInvoicesSuccess extends GetDraftSellInvoicesState {
  final List<InvoiceModel> invoices;
  const GetDraftSellInvoicesSuccess({
    required this.invoices,
  });
  @override
  // TODO: implement props
  List<Object> get props => [invoices];
}
