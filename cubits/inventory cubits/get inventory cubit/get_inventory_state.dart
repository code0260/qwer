part of 'get_inventory_cubit.dart';

sealed class GetInventoryState extends Equatable {
  const GetInventoryState();

  @override
  List<Object> get props => [];
}

final class GetInventoryInitial extends GetInventoryState {}

class GetInventoryLoading extends GetInventoryState {}

class GetInventoryFailure extends GetInventoryState {
  final String errorMessage;

  const GetInventoryFailure(this.errorMessage);
}

class GetInventorySuccess extends GetInventoryState {
  final StockModel stockModel;
  const GetInventorySuccess({
    required this.stockModel,
  });
  @override
  // TODO: implement props
  List<Object> get props => [stockModel];
}
