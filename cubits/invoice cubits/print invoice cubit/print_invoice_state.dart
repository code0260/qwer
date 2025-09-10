part of 'print_invoice_cubit.dart';

sealed class PrintInvoiceState extends Equatable {
  const PrintInvoiceState();

  @override
  List<Object> get props => [];
}

final class PrintInvoiceInitial extends PrintInvoiceState {}

class PrintInvoiceLoading extends PrintInvoiceState {}

class PrintInvoiceFailure extends PrintInvoiceState {
  final String errorMessage;

  const PrintInvoiceFailure({required this.errorMessage});
}

class PrintInvoiceSuccess extends PrintInvoiceState {}
