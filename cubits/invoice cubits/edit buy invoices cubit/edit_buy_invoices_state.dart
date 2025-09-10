part of 'edit_buy_invoices_cubit.dart';

sealed class EditBuyInvoiceState extends Equatable {
  const EditBuyInvoiceState();

  @override
  List<Object> get props => [];
}

final class EditBuyInvoiceInitial extends EditBuyInvoiceState {}

class EditBuyInvoiceLoading extends EditBuyInvoiceState {}

class EditBuyInvoiceFailure extends EditBuyInvoiceState {
  final String errorMessage;

  const EditBuyInvoiceFailure(this.errorMessage);
}

class EditBuyInvoiceSuccess extends EditBuyInvoiceState {}
