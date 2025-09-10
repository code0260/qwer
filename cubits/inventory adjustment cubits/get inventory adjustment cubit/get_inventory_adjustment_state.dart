part of 'get_inventory_adjustment_cubit.dart';

sealed class GetInventoryAdjustmentState extends Equatable {
  const GetInventoryAdjustmentState();

  @override
  List<Object> get props => [];
}

final class GetInventoryAdjustmentInitial extends GetInventoryAdjustmentState {}

class GetInventoryAdjustmentLoading extends GetInventoryAdjustmentState {}

class GetInventoryAdjustmentFailure extends GetInventoryAdjustmentState {
  final String errorMessage;

  const GetInventoryAdjustmentFailure(this.errorMessage);
}

class GetInventoryAdjustmentSuccess extends GetInventoryAdjustmentState {
  final List<InventoryAdjustmentModel> inventoryAdjustments;
  const GetInventoryAdjustmentSuccess({
    required this.inventoryAdjustments,
  });
  @override
  // TODO: implement props
  List<Object> get props => [inventoryAdjustments];
}
