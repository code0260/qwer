part of 'get_invoice_items_cubit.dart';

sealed class GetInvoiceItemsState extends Equatable {
  const GetInvoiceItemsState();

  @override
  List<Object> get props => [];
}

final class GetInvoiceItemsInitial extends GetInvoiceItemsState {}

class GetInvoiceItemsLoading extends GetInvoiceItemsState {}

class GetInvoiceItemsFailure extends GetInvoiceItemsState {
  final String errorMessage;

  const GetInvoiceItemsFailure(this.errorMessage);
}

class GetInvoiceItemsSuccess extends GetInvoiceItemsState {
  final AllInvoicesItemsModel allInvoicesItems;
  const GetInvoiceItemsSuccess({
    required this.allInvoicesItems,
  });
  @override
  // TODO: implement props
  List<Object> get props => [allInvoicesItems];
}
