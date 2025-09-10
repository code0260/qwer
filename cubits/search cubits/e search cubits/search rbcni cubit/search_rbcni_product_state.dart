part of 'search_rbcni_product_cubit.dart';

sealed class SearchRBCNIProductState extends Equatable {
  const SearchRBCNIProductState();

  @override
  List<Object> get props => [];
}

final class SearchRBCNIProductInitial extends SearchRBCNIProductState {}

class SearchRBCNIProductLoading extends SearchRBCNIProductState {}

class SearchRBCNIProductFailure extends SearchRBCNIProductState {
  final String errorMessage;

  const SearchRBCNIProductFailure(this.errorMessage);
}

class SearchRBCNIProductSuccess extends SearchRBCNIProductState {
  final List<ProductModel> products;
  const SearchRBCNIProductSuccess({
    required this.products,
  });
}
