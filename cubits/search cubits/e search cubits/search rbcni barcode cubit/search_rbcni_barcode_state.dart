part of 'search_rbcni_barcode_cubit.dart';

sealed class SearchRBCNIBarcodeState extends Equatable {
  const SearchRBCNIBarcodeState();

  @override
  List<Object> get props => [];
}

final class SearchRBCNIBarcodeInitial extends SearchRBCNIBarcodeState {}

class SearchRBCNIBarcodeLoading extends SearchRBCNIBarcodeState {}

class SearchRBCNIBarcodeFailure extends SearchRBCNIBarcodeState {
  final String errorMessage;

  const SearchRBCNIBarcodeFailure(this.errorMessage);
}

class SearchRBCNIBarcodeSuccess extends SearchRBCNIBarcodeState {
  final int? productId;
  const SearchRBCNIBarcodeSuccess({this.productId});
}
