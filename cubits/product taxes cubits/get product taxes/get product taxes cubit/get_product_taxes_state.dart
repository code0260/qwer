part of 'get_product_taxes_cubit.dart';

sealed class GetProductTaxesState extends Equatable {
  const GetProductTaxesState();

  @override
  List<Object> get props => [];
}

final class GetProductTaxesInitial extends GetProductTaxesState {}

class GetProductTaxesLoading extends GetProductTaxesState {}

class GetProductTaxesFailure extends GetProductTaxesState {
  final String errorMessage;

  const GetProductTaxesFailure(this.errorMessage);
}

class GetProductTaxesSuccess extends GetProductTaxesState {
  final List<ProductTaxModel> taxes;
  const GetProductTaxesSuccess({
    required this.taxes,
  });
  @override
  // TODO: implement props
  List<Object> get props => [taxes];
}
