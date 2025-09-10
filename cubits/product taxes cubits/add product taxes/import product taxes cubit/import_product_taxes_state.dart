part of 'import_product_taxes_cubit.dart';

sealed class ImportProductTaxesState extends Equatable {
  const ImportProductTaxesState();

  @override
  List<Object> get props => [];
}

final class ImportProductTaxesInitial extends ImportProductTaxesState {}

class ImportProductTaxesLoading extends ImportProductTaxesState {}

class ImportProductTaxesFailure extends ImportProductTaxesState {
  final String errorMessage;

  const ImportProductTaxesFailure({required this.errorMessage});
}

class ImportProductTaxesSuccess extends ImportProductTaxesState {}
