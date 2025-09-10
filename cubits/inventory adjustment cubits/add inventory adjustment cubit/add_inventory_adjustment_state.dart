part of 'add_inventory_adjustment_cubit.dart';

sealed class AddInventoryAdjustmentState extends Equatable {
  const AddInventoryAdjustmentState();

  @override
  List<Object> get props => [];
}

final class AddInventoryAdjustmentInitial extends AddInventoryAdjustmentState {}

class AddInventoryAdjustmentLoading extends AddInventoryAdjustmentState {}

class AddInventoryAdjustmentFailure extends AddInventoryAdjustmentState {
  final String errorMessage;

  const AddInventoryAdjustmentFailure(this.errorMessage);
}

class AddInventoryAdjustmentSuccess extends AddInventoryAdjustmentState {
  const AddInventoryAdjustmentSuccess();
}
