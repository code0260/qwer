part of 'get_product_cubit.dart';

sealed class GetProductState extends Equatable {
  const GetProductState();

  @override
  List<Object> get props => [];
}

final class GetProductInitial extends GetProductState {}

class GetProductLoading extends GetProductState {}

class GetProductFailure extends GetProductState {
  final String errorMessage;

  const GetProductFailure(this.errorMessage);
}

class GetProductSuccess extends GetProductState {
  final List<ProductModel> product;
  const GetProductSuccess({
    required this.product,
  });
}
