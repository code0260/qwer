part of 'edit_buy_draft_invoice_cubit.dart';

sealed class EditBuyDraftInvoiceState extends Equatable {
  const EditBuyDraftInvoiceState();

  @override
  List<Object> get props => [];
}

final class EditBuyDraftInvoiceInitial extends EditBuyDraftInvoiceState {}

class EditBuyDraftInvoiceLoading extends EditBuyDraftInvoiceState {}

class EditBuyDraftInvoiceFailure extends EditBuyDraftInvoiceState {
  final String errorMessage;

  const EditBuyDraftInvoiceFailure({required this.errorMessage});
}

class EditBuyDraftInvoiceSuccess extends EditBuyDraftInvoiceState {
  final int invoiceId;

  const EditBuyDraftInvoiceSuccess({required this.invoiceId});
}
