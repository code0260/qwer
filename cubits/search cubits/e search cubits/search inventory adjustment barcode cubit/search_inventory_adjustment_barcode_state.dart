part of 'search_inventory_adjustment_barcode_cubit.dart';

sealed class SearchInventoryAdjustmentBarcodeState extends Equatable {
  const SearchInventoryAdjustmentBarcodeState();

  @override
  List<Object> get props => [];
}

final class SearchInventoryAdjustmentBarcodeInitial
    extends SearchInventoryAdjustmentBarcodeState {}

class SearchInventoryAdjustmentBarcodeLoading
    extends SearchInventoryAdjustmentBarcodeState {}

class SearchInventoryAdjustmentBarcodeFailure
    extends SearchInventoryAdjustmentBarcodeState {
  final String errorMessage;

  const SearchInventoryAdjustmentBarcodeFailure(this.errorMessage);
}

class SearchInventoryAdjustmentBarcodeSuccess
    extends SearchInventoryAdjustmentBarcodeState {
  final int? productId;
  const SearchInventoryAdjustmentBarcodeSuccess({this.productId});
}
