part of 'get_taxes_cubit.dart';

sealed class GetTaxesState extends Equatable {
  const GetTaxesState();

  @override
  List<Object> get props => [];
}

final class GetTaxesInitial extends GetTaxesState {}

class GetTaxesLoading extends GetTaxesState {}

class GetTaxesFailure extends GetTaxesState {
  final String errorMessage;

  const GetTaxesFailure(this.errorMessage);
}

class GetTaxesSuccess extends GetTaxesState {
  final List<TaxesModel> taxes;
  const GetTaxesSuccess({
    required this.taxes,
  });
  @override
  // TODO: implement props
  List<Object> get props => [taxes];
}
