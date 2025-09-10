part of 'search_buy_edit_product_cubit.dart';

sealed class SearchBuyEditProductState extends Equatable {
  const SearchBuyEditProductState();

  @override
  List<Object> get props => [];
}

final class SearchBuyEditProductInitial extends SearchBuyEditProductState {}

class SearchBuyEditProductLoading extends SearchBuyEditProductState {}

class SearchBuyEditProductFailure extends SearchBuyEditProductState {
  final String errorMessage;

  const SearchBuyEditProductFailure(this.errorMessage);
}

class SearchBuyEditProductSuccess extends SearchBuyEditProductState {
  final List<ProductModel> products;
  const SearchBuyEditProductSuccess({
    required this.products,
  });
}
