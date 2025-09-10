part of 'add_vacation_cubit.dart';

sealed class AddVacationState extends Equatable {
  const AddVacationState();

  @override
  List<Object> get props => [];
}

final class AddVacationInitial extends AddVacationState {}

class AddVacationLoading extends AddVacationState {}

class AddVacationFailure extends AddVacationState {
  final String errorMessage;

  const AddVacationFailure(this.errorMessage);
}

class AddVacationSuccess extends AddVacationState {}
