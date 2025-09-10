part of 'transfer_draft_buy_invoice_cubit.dart';

sealed class TransferDraftBuyInvoiceState extends Equatable {
  const TransferDraftBuyInvoiceState();

  @override
  List<Object> get props => [];
}

final class TransferDraftBuyInvoiceInitial
    extends TransferDraftBuyInvoiceState {}

class TransferDraftBuyInvoiceLoading extends TransferDraftBuyInvoiceState {}

class TransferDraftBuyInvoiceFailure extends TransferDraftBuyInvoiceState {
  final String errorMessage;

  const TransferDraftBuyInvoiceFailure({required this.errorMessage});
}

class TransferDraftBuyInvoiceSuccess extends TransferDraftBuyInvoiceState {}
