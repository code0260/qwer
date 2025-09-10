part of 'search_sell_edit_product_cubit.dart';

sealed class SearchSellEditProductState extends Equatable {
  const SearchSellEditProductState();

  @override
  List<Object> get props => [];
}

final class SearchSellEditProductInitial extends SearchSellEditProductState {}

class SearchSellEditProductLoading extends SearchSellEditProductState {}

class SearchSellEditProductFailure extends SearchSellEditProductState {
  final String errorMessage;

  const SearchSellEditProductFailure(this.errorMessage);
}

class SearchSellEditProductSuccess extends SearchSellEditProductState {
  final List<GetProductModel> products;
  const SearchSellEditProductSuccess({
    required this.products,
  });
}
