part of 'product_inventory_cubit.dart';

sealed class ProductInventoryState extends Equatable {
  const ProductInventoryState();

  @override
  List<Object> get props => [];
}

final class ProductInventoryInitial extends ProductInventoryState {}

class ProductInventoryLoading extends ProductInventoryState {}

class ProductInventoryFailure extends ProductInventoryState {
  final String errorMessage;

  const ProductInventoryFailure({required this.errorMessage});
}

class ProductInventorySuccess extends ProductInventoryState {}
