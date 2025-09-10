part of 'add_tax_cubit.dart';

sealed class AddTaxState extends Equatable {
  const AddTaxState();

  @override
  List<Object> get props => [];
}

final class AddTaxInitial extends AddTaxState {}

class AddTaxLoading extends AddTaxState {}

class AddTaxFailure extends AddTaxState {
  final String errorMessage;

  const AddTaxFailure(this.errorMessage);
}

class AddTaxSuccess extends AddTaxState {
  const AddTaxSuccess();
}
