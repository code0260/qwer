part of 'search_buy_product_cubit.dart';

sealed class SearchBuyProductState extends Equatable {
  const SearchBuyProductState();

  @override
  List<Object> get props => [];
}

final class SearchBuyProductInitial extends SearchBuyProductState {}

class SearchBuyProductLoading extends SearchBuyProductState {}

class SearchBuyProductFailure extends SearchBuyProductState {
  final String errorMessage;

  const SearchBuyProductFailure(this.errorMessage);
}

class SearchBuyProductSuccess extends SearchBuyProductState {
  final List<ProductModel> products;
  const SearchBuyProductSuccess({
    required this.products,
  });
}
