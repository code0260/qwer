part of 'transfer_draft_sell_invoice_cubit.dart';

sealed class TransferDraftSellInvoiceState extends Equatable {
  const TransferDraftSellInvoiceState();

  @override
  List<Object> get props => [];
}

final class TransferDraftSellInvoiceInitial
    extends TransferDraftSellInvoiceState {}

class TransferDraftSellInvoiceLoading extends TransferDraftSellInvoiceState {}

class TransferDraftSellInvoiceFailure extends TransferDraftSellInvoiceState {
  final String errorMessage;

  const TransferDraftSellInvoiceFailure({required this.errorMessage});
}

class TransferDraftSellInvoiceSuccess extends TransferDraftSellInvoiceState {}
