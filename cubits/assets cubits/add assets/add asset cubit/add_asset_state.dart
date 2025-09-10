part of 'add_asset_cubit.dart';

abstract class AddAssetState extends Equatable {
  const AddAssetState();

  @override
  List<Object> get props => [];
}

class AddAssetInitial extends AddAssetState {
  final bool hasDepreciation;

  const AddAssetInitial({required this.hasDepreciation});
  @override
  // TODO: implement props
  List<Object> get props => [hasDepreciation];
}

class AddAssetLoading extends AddAssetState {}

class AddAssetFailure extends AddAssetState {
  final String errorMessage;

  const AddAssetFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class AddAssetSuccess extends AddAssetState {}
