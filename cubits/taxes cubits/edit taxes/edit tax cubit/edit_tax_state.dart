part of 'edit_tax_cubit.dart';

sealed class EditTaxState extends Equatable {
  const EditTaxState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class EditTaxInitial extends EditTaxState {}

class EditTaxLoading extends EditTaxState {}

class EditTaxFailure extends EditTaxState {
  final String errorMessage;

  const EditTaxFailure(this.errorMessage);
}

class EditTaxSuccess extends EditTaxState {}
