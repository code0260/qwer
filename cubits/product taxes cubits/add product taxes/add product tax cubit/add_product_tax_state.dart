part of 'add_product_tax_cubit.dart';

sealed class AddProductTaxState extends Equatable {
  const AddProductTaxState();

  @override
  List<Object> get props => [];
}

final class AddProductTaxInitial extends AddProductTaxState {}

class AddProductTaxLoading extends AddProductTaxState {}

class AddProductTaxFailure extends AddProductTaxState {
  final String errorMessage;

  const AddProductTaxFailure(this.errorMessage);
}

class AddProductTaxSuccess extends AddProductTaxState {
  const AddProductTaxSuccess();
}
