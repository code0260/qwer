// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_buy_invoice_cubit.dart';

sealed class AddBuyInvoiceState extends Equatable {
  const AddBuyInvoiceState();

  @override
  List<Object> get props => [];
}

final class AddBuyInvoiceInitial extends AddBuyInvoiceState {}

class AddBuyInvoiceLoading extends AddBuyInvoiceState {}

class AddBuyInvoiceFailure extends AddBuyInvoiceState {
  final String errorMessage;

  const AddBuyInvoiceFailure({required this.errorMessage});
}

class AddBuyInvoiceSuccess extends AddBuyInvoiceState {
  final int invoiceId;

  const AddBuyInvoiceSuccess({required this.invoiceId});
}

class AddBuyClientChangedInvoiceSuccess extends AddBuyInvoiceState {
  final int clientId;

  const AddBuyClientChangedInvoiceSuccess({required this.clientId});

  @override
  bool operator ==(covariant AddBuyClientChangedInvoiceSuccess other) {
    if (identical(this, other)) return true;

    return other.clientId == clientId;
  }

  @override
  int get hashCode => clientId.hashCode;
}
