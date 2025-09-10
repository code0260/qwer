part of 'search_inventory_adjustment_product_cubit.dart';

sealed class SearchInventoryAdjustmentProductState extends Equatable {
  const SearchInventoryAdjustmentProductState();

  @override
  List<Object> get props => [];
}

final class SearchInventoryAdjustmentProductInitial
    extends SearchInventoryAdjustmentProductState {}

class SearchInventoryAdjustmentProductLoading
    extends SearchInventoryAdjustmentProductState {}

class SearchInventoryAdjustmentProductFailure
    extends SearchInventoryAdjustmentProductState {
  final String errorMessage;

  const SearchInventoryAdjustmentProductFailure(this.errorMessage);
}

class SearchInventoryAdjustmentProductSuccess
    extends SearchInventoryAdjustmentProductState {
  final List<ProductModel> products;
  const SearchInventoryAdjustmentProductSuccess({
    required this.products,
  });
}
