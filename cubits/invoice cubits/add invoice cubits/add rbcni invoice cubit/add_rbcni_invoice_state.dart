part of 'add_rbcni_invoice_cubit.dart';

sealed class AddRBCNIInvoiceState extends Equatable {
  const AddRBCNIInvoiceState();

  @override
  List<Object> get props => [];
}

final class AddRBCNIInvoiceInitial extends AddRBCNIInvoiceState {}

class AddRBCNIInvoiceLoading extends AddRBCNIInvoiceState {}

class AddRBCNIInvoiceFailure extends AddRBCNIInvoiceState {
  final String errorMessage;

  const AddRBCNIInvoiceFailure({required this.errorMessage});
}

class AddRBCNIInvoiceSuccess extends AddRBCNIInvoiceState {}
