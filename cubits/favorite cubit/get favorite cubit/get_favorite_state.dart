part of 'get_favorite_cubit.dart';

sealed class GetFavoriteState extends Equatable {
  const GetFavoriteState();

  @override
  List<Object> get props => [];
}

final class GetFavoriteInitial extends GetFavoriteState {}

class GetFavoriteLoading extends GetFavoriteState {}

class GetFavoriteFailure extends GetFavoriteState {
  final String errorMessage;

  const GetFavoriteFailure(this.errorMessage);
}

class GetFavoriteSuccess extends GetFavoriteState {
  final List<ProductModel> products;
  const GetFavoriteSuccess({
    required this.products,
  });
}
