part of 'get_assets_cubit.dart';

sealed class GetAssetState extends Equatable {
  const GetAssetState();

  @override
  List<Object> get props => [];
}

final class GetAssetInitial extends GetAssetState {}

class GetAssetLoading extends GetAssetState {}

class GetAssetFailure extends GetAssetState {
  final String errorMessage;

  const GetAssetFailure(this.errorMessage);
}

class GetAssetSuccess extends GetAssetState {
  final List<AssetModel> assets;
  const GetAssetSuccess({
    required this.assets,
  });
}
