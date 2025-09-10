part of 'edit_sell_draft_invoice_cubit.dart';

sealed class EditSellDraftInvoiceState extends Equatable {
  const EditSellDraftInvoiceState();

  @override
  List<Object> get props => [];
}

final class EditSellDraftInvoiceInitial extends EditSellDraftInvoiceState {}

class EditSellDraftInvoiceLoading extends EditSellDraftInvoiceState {}

class EditSellDraftInvoiceFailure extends EditSellDraftInvoiceState {
  final String errorMessage;

  const EditSellDraftInvoiceFailure({required this.errorMessage});
}

class EditSellDraftInvoiceSuccess extends EditSellDraftInvoiceState {
  final int invoiceId;

  const EditSellDraftInvoiceSuccess({required this.invoiceId});
}
