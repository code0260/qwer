part of 'edit_search_inventory_adjustment_cart_cubit.dart';

sealed class EditSearchInventoryAdjustmentCartState extends Equatable {
  const EditSearchInventoryAdjustmentCartState();

  @override
  List<Object> get props => [];
}

final class EditSearchInventoryAdjustmentCart
    extends EditSearchInventoryAdjustmentCartState {
  final int id;
  final bool isAdd;
  const EditSearchInventoryAdjustmentCart(
      {required this.isAdd, required this.id});
  @override
  List<Object> get props => [id, isAdd];
}
