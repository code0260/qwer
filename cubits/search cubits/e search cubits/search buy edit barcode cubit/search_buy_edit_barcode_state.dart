part of 'search_buy_edit_barcode_cubit.dart';

sealed class SearchBuyEditBarcodeState extends Equatable {
  const SearchBuyEditBarcodeState();

  @override
  List<Object> get props => [];
}

final class SearchBuyEditBarcodeInitial extends SearchBuyEditBarcodeState {}

class SearchBuyEditBarcodeLoading extends SearchBuyEditBarcodeState {}

class SearchBuyEditBarcodeFailure extends SearchBuyEditBarcodeState {
  final String errorMessage;

  const SearchBuyEditBarcodeFailure(this.errorMessage);
}

class SearchBuyEditBarcodeSuccess extends SearchBuyEditBarcodeState {
  final int? productId;
  const SearchBuyEditBarcodeSuccess({this.productId});
}
