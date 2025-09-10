part of 'get_draft_buy_invoice_cubit.dart';

sealed class GetDraftBuyInvoicesState extends Equatable {
  const GetDraftBuyInvoicesState();

  @override
  List<Object> get props => [];
}

final class GetDraftBuyInvoicesInitial extends GetDraftBuyInvoicesState {}

class GetDraftBuyInvoicesLoading extends GetDraftBuyInvoicesState {}

class GetDraftBuyInvoicesFailure extends GetDraftBuyInvoicesState {
  final String errorMessage;

  const GetDraftBuyInvoicesFailure(this.errorMessage);
}

class GetDraftBuyInvoicesSuccess extends GetDraftBuyInvoicesState {
  final List<InvoiceModel> invoices;
  const GetDraftBuyInvoicesSuccess({
    required this.invoices,
  });
  @override
  // TODO: implement props
  List<Object> get props => [invoices];
}
