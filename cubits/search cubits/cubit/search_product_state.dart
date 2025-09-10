part of 'search_product_cubit.dart';

sealed class SearchProductState extends Equatable {
  const SearchProductState();

  @override
  List<Object> get props => [];
}

final class SearchProductInitial extends SearchProductState {}

class SearchProductLoading extends SearchProductState {}

class SearchProductFailure extends SearchProductState {
  final String errorMessage;

  const SearchProductFailure(this.errorMessage);
}

class SearchProductSuccess extends SearchProductState {
  final List<ProductModel> products;
  const SearchProductSuccess({
    required this.products,
  });
}
