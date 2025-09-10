part of 'pdf_invoice_cubit.dart';

sealed class PdfInvoiceState extends Equatable {
  const PdfInvoiceState();

  @override
  List<Object> get props => [];
}

final class PdfInvoiceInitial extends PdfInvoiceState {}

class PdfInvoiceLoading extends PdfInvoiceState {}

class PdfInvoiceFailure extends PdfInvoiceState {
  final String errorMessage;

  const PdfInvoiceFailure({required this.errorMessage});
}

class PdfInvoiceSuccess extends PdfInvoiceState {}
