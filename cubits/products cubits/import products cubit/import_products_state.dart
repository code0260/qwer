part of 'import_products_cubit.dart';

sealed class ImportProductsState extends Equatable {
  const ImportProductsState();

  @override
  List<Object> get props => [];
}

final class ImportProductsInitial extends ImportProductsState {}

class ImportProductsLoading extends ImportProductsState {}

class ImportProductsFailure extends ImportProductsState {
  final String errorMessage;

  const ImportProductsFailure({required this.errorMessage});
}

class ImportProductsSuccess extends ImportProductsState {}
