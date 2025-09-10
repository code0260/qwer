// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_profit_cubit.dart';

sealed class ProductProfitState extends Equatable {
  const ProductProfitState();

  @override
  List<Object> get props => [];
}

final class ProductProfitInitial extends ProductProfitState {}

class ProductProfitLoading extends ProductProfitState {}

class ProductProfitFailure extends ProductProfitState {
  final String errorMessage;

  const ProductProfitFailure({required this.errorMessage});
}

class ProductProfitSuccess extends ProductProfitState {
  final String path;
  const ProductProfitSuccess({
    required this.path,
  });
}
