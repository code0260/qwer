part of 'add_rscni_invoice_cubit.dart';

sealed class AddRSCNIInvoiceState extends Equatable {
  const AddRSCNIInvoiceState();

  @override
  List<Object> get props => [];
}

final class AddRSCNIInvoiceInitial extends AddRSCNIInvoiceState {}

class AddRSCNIInvoiceLoading extends AddRSCNIInvoiceState {}

class AddRSCNIInvoiceFailure extends AddRSCNIInvoiceState {
  final String errorMessage;

  const AddRSCNIInvoiceFailure({required this.errorMessage});
}

class AddRSCNIInvoiceSuccess extends AddRSCNIInvoiceState {}
