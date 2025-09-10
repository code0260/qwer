part of 'delete_vacation_cubit.dart';

sealed class DeleteVacationState extends Equatable {
  const DeleteVacationState();

  @override
  List<Object> get props => [];
}

final class DeleteVacationInitial extends DeleteVacationState {}

class DeleteVacationLoading extends DeleteVacationState {}

class DeleteVacationFailure extends DeleteVacationState {
  final String errorMessage;

  const DeleteVacationFailure({required this.errorMessage});
}

class DeleteVacationSuccess extends DeleteVacationState {}
