part of 'upload_all_sell_invoice_cubit.dart';

sealed class UploadAllSellInvoiceState extends Equatable {
  const UploadAllSellInvoiceState();

  @override
  List<Object> get props => [];
}

final class UploadAllSellInvoiceInitial extends UploadAllSellInvoiceState {}

class UploadAllSellInvoiceLoading extends UploadAllSellInvoiceState {}

class UploadAllSellInvoiceFailure extends UploadAllSellInvoiceState {
  final String errorMessage;

  const UploadAllSellInvoiceFailure({required this.errorMessage});
}

class UploadAllSellInvoiceSuccess extends UploadAllSellInvoiceState {}
