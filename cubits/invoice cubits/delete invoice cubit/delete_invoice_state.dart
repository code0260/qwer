part of 'delete_invoice_cubit.dart';

sealed class DeleteInvoiceState extends Equatable {
  const DeleteInvoiceState();

  @override
  List<Object> get props => [];
}

final class DeleteInvoiceInitial extends DeleteInvoiceState {}

class DeleteInvoiceLoading extends DeleteInvoiceState {}

class DeleteInvoiceFailure extends DeleteInvoiceState {
  final String errorMessage;

  const DeleteInvoiceFailure({required this.errorMessage});
}

class DeleteInvoiceSuccess extends DeleteInvoiceState {}
