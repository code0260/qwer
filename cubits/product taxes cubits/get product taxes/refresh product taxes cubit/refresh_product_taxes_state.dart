part of 'refresh_product_taxes_cubit.dart';

sealed class RefreshProductTaxesState extends Equatable {
  const RefreshProductTaxesState();

  @override
  List<Object> get props => [];
}

final class RefreshProductTaxesInitial extends RefreshProductTaxesState {}

class RefreshProductTaxesLoading extends RefreshProductTaxesState {}

class RefreshProductTaxesFailure extends RefreshProductTaxesState {
  final String errorMessage;

  const RefreshProductTaxesFailure(this.errorMessage);
}

class RefreshProductTaxesSuccess extends RefreshProductTaxesState {}
