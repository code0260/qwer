part of 'delete_compensation_cubit.dart';

sealed class DeleteCompensationState extends Equatable {
  const DeleteCompensationState();

  @override
  List<Object> get props => [];
}

final class DeleteCompensationInitial extends DeleteCompensationState {}

class DeleteCompensationLoading extends DeleteCompensationState {}

class DeleteCompensationFailure extends DeleteCompensationState {
  final String errorMessage;

  const DeleteCompensationFailure({required this.errorMessage});
}

class DeleteCompensationSuccess extends DeleteCompensationState {}
