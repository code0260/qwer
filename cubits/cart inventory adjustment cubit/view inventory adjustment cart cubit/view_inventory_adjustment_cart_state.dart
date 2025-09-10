part of 'view_inventory_adjustment_cart_cubit.dart';

sealed class ViewInventoryAdjustmentCartState extends Equatable {
  const ViewInventoryAdjustmentCartState();

  @override
  List<Object> get props => [];
}

final class ViewInventoryAdjustmentCartInitial
    extends ViewInventoryAdjustmentCartState {}

class ViewInventoryAdjustmentCartSuccess
    extends ViewInventoryAdjustmentCartState {
  final List<InventoryAdjustmentDataModel> items;
  final int itemsLength; // this is used to make the two instances not equal
  const ViewInventoryAdjustmentCartSuccess(
      {required this.items, required this.itemsLength});
  @override
  List<Object> get props => [itemsLength];
}
