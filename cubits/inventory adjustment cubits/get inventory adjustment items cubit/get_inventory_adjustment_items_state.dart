part of 'get_inventory_adjustment_items_cubit.dart';

sealed class GetInventoryAdjustmentItemsState extends Equatable {
  const GetInventoryAdjustmentItemsState();

  @override
  List<Object> get props => [];
}

final class GetInventoryAdjustmentItemsInitial
    extends GetInventoryAdjustmentItemsState {}

class GetInventoryAdjustmentItemsLoading
    extends GetInventoryAdjustmentItemsState {}

class GetInventoryAdjustmentItemsFailure
    extends GetInventoryAdjustmentItemsState {
  final String errorMessage;

  const GetInventoryAdjustmentItemsFailure(this.errorMessage);
}

class GetInventoryAdjustmentItemsSuccess
    extends GetInventoryAdjustmentItemsState {
  final GetInventoryAdjustmentItemModel getInventoryAdjustmentItemModel;
  const GetInventoryAdjustmentItemsSuccess({
    required this.getInventoryAdjustmentItemModel,
  });
  @override
  // TODO: implement props
  List<Object> get props => [getInventoryAdjustmentItemModel];
}
