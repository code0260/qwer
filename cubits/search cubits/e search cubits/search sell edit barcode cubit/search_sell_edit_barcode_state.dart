part of 'search_sell_edit_barcode_cubit.dart';

sealed class SearchSellEditBarcodeState extends Equatable {
  const SearchSellEditBarcodeState();

  @override
  List<Object> get props => [];
}

final class SearchSellEditBarcodeInitial extends SearchSellEditBarcodeState {}

class SearchSellEditBarcodeLoading extends SearchSellEditBarcodeState {}

class SearchSellEditBarcodeFailure extends SearchSellEditBarcodeState {
  final String errorMessage;

  const SearchSellEditBarcodeFailure(this.errorMessage);
}

class SearchSellEditBarcodeSuccess extends SearchSellEditBarcodeState {
  final int? productId;
  const SearchSellEditBarcodeSuccess({this.productId});
}
