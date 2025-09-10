part of 'upload_all_buy_invoice_cubit.dart';

sealed class UploadAllBuyInvoiceState extends Equatable {
  const UploadAllBuyInvoiceState();

  @override
  List<Object> get props => [];
}

final class UploadAllBuyInvoiceInitial extends UploadAllBuyInvoiceState {}

class UploadAllBuyInvoiceLoading extends UploadAllBuyInvoiceState {}

class UploadAllBuyInvoiceFailure extends UploadAllBuyInvoiceState {
  final String errorMessage;

  const UploadAllBuyInvoiceFailure({required this.errorMessage});
}

class UploadAllBuyInvoiceSuccess extends UploadAllBuyInvoiceState {}
