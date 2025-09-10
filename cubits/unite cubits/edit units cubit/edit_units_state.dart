part of 'edit_units_cubit.dart';

sealed class EditUnitState extends Equatable {
  const EditUnitState();

  @override
  List<Object> get props => [];
}

final class EditUnitInitial extends EditUnitState {}

class EditUnitLoading extends EditUnitState {}

class EditUnitFailure extends EditUnitState {
  final String errorMessage;

  const EditUnitFailure(this.errorMessage);
}

class EditUnitSuccess extends EditUnitState {}
