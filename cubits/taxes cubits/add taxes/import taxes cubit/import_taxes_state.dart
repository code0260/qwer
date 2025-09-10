part of 'import_taxes_cubit.dart';

sealed class ImportTaxesState extends Equatable {
  const ImportTaxesState();

  @override
  List<Object> get props => [];
}

final class ImportTaxesInitial extends ImportTaxesState {}

class ImportTaxesLoading extends ImportTaxesState {}

class ImportTaxesFailure extends ImportTaxesState {
  final String errorMessage;

  const ImportTaxesFailure({required this.errorMessage});
}

class ImportTaxesSuccess extends ImportTaxesState {}
