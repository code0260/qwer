part of 'get_latest_invoice_number_cubit.dart';

sealed class GetLatestInvoiceNumberState extends Equatable {
  const GetLatestInvoiceNumberState();

  @override
  List<Object> get props => [];
}

final class GetLatestInvoiceNumberInitial extends GetLatestInvoiceNumberState {}

class GetLatestInvoiceNumberLoading extends GetLatestInvoiceNumberState {}

class GetLatestInvoiceNumberFailure extends GetLatestInvoiceNumberState {
  final String errorMessage;

  const GetLatestInvoiceNumberFailure(this.errorMessage);
}

class GetLatestInvoiceNumberSuccess extends GetLatestInvoiceNumberState {}
