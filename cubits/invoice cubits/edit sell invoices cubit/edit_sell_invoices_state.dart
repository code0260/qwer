part of 'edit_sell_invoices_cubit.dart';

sealed class EditSellInvoiceState extends Equatable {
  const EditSellInvoiceState();

  @override
  List<Object> get props => [];
}

final class EditSellInvoiceInitial extends EditSellInvoiceState {}

class EditSellInvoiceLoading extends EditSellInvoiceState {}

class EditSellInvoiceFailure extends EditSellInvoiceState {
  final String errorMessage;

  const EditSellInvoiceFailure(this.errorMessage);
}

class EditSellInvoiceSuccess extends EditSellInvoiceState {}
