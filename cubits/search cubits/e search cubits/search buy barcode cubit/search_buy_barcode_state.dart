part of 'search_buy_barcode_cubit.dart';

sealed class SearchBuyBarcodeState extends Equatable {
  const SearchBuyBarcodeState();

  @override
  List<Object> get props => [];
}

final class SearchBuyBarcodeInitial extends SearchBuyBarcodeState {}

class SearchBuyBarcodeLoading extends SearchBuyBarcodeState {}

class SearchBuyBarcodeFailure extends SearchBuyBarcodeState {
  final String errorMessage;

  const SearchBuyBarcodeFailure(this.errorMessage);
}

class SearchBuyBarcodeSuccess extends SearchBuyBarcodeState {
  final int? productId;
  const SearchBuyBarcodeSuccess({this.productId});
}
