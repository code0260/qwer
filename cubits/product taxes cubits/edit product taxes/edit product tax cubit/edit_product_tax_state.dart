part of 'edit_product_tax_cubit.dart';

sealed class EditProductTaxState extends Equatable {
  const EditProductTaxState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class EditProductTaxInitial extends EditProductTaxState {}

class EditProductTaxLoading extends EditProductTaxState {}

class EditProductTaxFailure extends EditProductTaxState {
  final String errorMessage;

  const EditProductTaxFailure(this.errorMessage);
}

class EditProductTaxSuccess extends EditProductTaxState {}
