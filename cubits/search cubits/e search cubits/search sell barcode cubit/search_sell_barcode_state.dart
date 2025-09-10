part of 'search_sell_barcode_cubit.dart';

sealed class SearchSellBarcodeState extends Equatable {
  const SearchSellBarcodeState();

  @override
  List<Object> get props => [];
}

final class SearchSellBarcodeInitial extends SearchSellBarcodeState {}

class SearchSellBarcodeLoading extends SearchSellBarcodeState {}

class SearchSellBarcodeFailure extends SearchSellBarcodeState {
  final String errorMessage;

  const SearchSellBarcodeFailure(this.errorMessage);
}

class SearchSellBarcodeSuccess extends SearchSellBarcodeState {
  final int? productId;
  const SearchSellBarcodeSuccess({this.productId});
}
