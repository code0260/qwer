part of 'delete_draft_invoice_cubit.dart';

sealed class DeleteDraftInvoiceState extends Equatable {
  const DeleteDraftInvoiceState();

  @override
  List<Object> get props => [];
}

final class DeleteDraftInvoiceInitial extends DeleteDraftInvoiceState {}

class DeleteDraftInvoiceLoading extends DeleteDraftInvoiceState {}

class DeleteDraftInvoiceFailure extends DeleteDraftInvoiceState {
  final String errorMessage;

  const DeleteDraftInvoiceFailure({required this.errorMessage});
}

class DeleteDraftInvoiceSuccess extends DeleteDraftInvoiceState {}
