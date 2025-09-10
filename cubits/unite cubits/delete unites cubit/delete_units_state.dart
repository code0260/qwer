part of 'delete_units_cubit.dart';

sealed class DeleteUnitState extends Equatable {
  const DeleteUnitState();

  @override
  List<Object> get props => [];
}

final class DeleteUnitInitial extends DeleteUnitState {}

class DeleteUnitLoading extends DeleteUnitState {}

class DeleteUnitFailure extends DeleteUnitState {
  final String errorMessage;

  const DeleteUnitFailure(this.errorMessage);
}

class DeleteUnitSuccess extends DeleteUnitState {}
