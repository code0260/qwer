part of 'add_units_cubit.dart';

sealed class AddUnitState extends Equatable {
  const AddUnitState();

  @override
  List<Object> get props => [];
}

final class AddUnitInitial extends AddUnitState {}

class AddUnitLoading extends AddUnitState {}

class AddUnitFailure extends AddUnitState {
  final String errorMessage;

  const AddUnitFailure(this.errorMessage);
}

class AddUnitSuccess extends AddUnitState {}
