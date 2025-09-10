part of 'sell_asset_cubit.dart';

abstract class SellAssetState extends Equatable {
  const SellAssetState();

  @override
  List<Object> get props => [];
}

class SellAssetInitial extends SellAssetState {
  final bool hasDepreciation;

  const SellAssetInitial({required this.hasDepreciation});
  @override
  // TODO: implement props
  List<Object> get props => [hasDepreciation];
}

class SellAssetLoading extends SellAssetState {}

class SellAssetFailure extends SellAssetState {
  final String errorMessage;

  const SellAssetFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class SellAssetSuccess extends SellAssetState {}
