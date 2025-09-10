part of 'search_rscni_product_cubit.dart';

sealed class SearchRSCNIProductState extends Equatable {
  const SearchRSCNIProductState();

  @override
  List<Object> get props => [];
}

final class SearchRSCNIProductInitial extends SearchRSCNIProductState {}

class SearchRSCNIProductLoading extends SearchRSCNIProductState {}

class SearchRSCNIProductFailure extends SearchRSCNIProductState {
  final String errorMessage;

  const SearchRSCNIProductFailure(this.errorMessage);
}

class SearchRSCNIProductSuccess extends SearchRSCNIProductState {
  final List<GetProductModel> products;
  const SearchRSCNIProductSuccess({
    required this.products,
  });
}
