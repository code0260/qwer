part of 'delete_product_taxes_cubit.dart';

sealed class DeleteProductTaxState extends Equatable {
  const DeleteProductTaxState();

  @override
  List<Object> get props => [];
}

final class DeleteProductTaxInitial extends DeleteProductTaxState {}

class DeleteProductTaxLoading extends DeleteProductTaxState {}

class DeleteProductTaxFailure extends DeleteProductTaxState {
  final String errorMessage;

  const DeleteProductTaxFailure({required this.errorMessage});
}

class DeleteProductTaxSuccess extends DeleteProductTaxState {}
