part of 'search_sell_product_cubit.dart';

sealed class SearchSellProductState extends Equatable {
  const SearchSellProductState();

  @override
  List<Object> get props => [];
}

final class SearchSellProductInitial extends SearchSellProductState {}

class SearchSellProductLoading extends SearchSellProductState {}

class SearchSellProductFailure extends SearchSellProductState {
  final String errorMessage;

  const SearchSellProductFailure(this.errorMessage);
}

class SearchSellProductSuccess extends SearchSellProductState {
  final List<GetProductModel> products;
  const SearchSellProductSuccess({
    required this.products,
  });
}
