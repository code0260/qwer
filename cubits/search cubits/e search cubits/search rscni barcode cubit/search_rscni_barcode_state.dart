part of 'search_rscni_barcode_cubit.dart';

sealed class SearchRSCNIBarcodeState extends Equatable {
  const SearchRSCNIBarcodeState();

  @override
  List<Object> get props => [];
}

final class SearchRSCNIBarcodeInitial extends SearchRSCNIBarcodeState {}

class SearchRSCNIBarcodeLoading extends SearchRSCNIBarcodeState {}

class SearchRSCNIBarcodeFailure extends SearchRSCNIBarcodeState {
  final String errorMessage;

  const SearchRSCNIBarcodeFailure(this.errorMessage);
}

class SearchRSCNIBarcodeSuccess extends SearchRSCNIBarcodeState {
  final int? productId;
  const SearchRSCNIBarcodeSuccess({this.productId});
}
