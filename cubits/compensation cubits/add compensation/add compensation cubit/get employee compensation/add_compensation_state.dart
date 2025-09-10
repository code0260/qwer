part of 'add_compensation_cubit.dart';

sealed class AddCompensationState extends Equatable {
  const AddCompensationState();

  @override
  List<Object> get props => [];
}

final class AddCompensationInitial extends AddCompensationState {}

class AddCompensationLoading extends AddCompensationState {}

class AddCompensationFailure extends AddCompensationState {
  final String errorMessage;

  const AddCompensationFailure(this.errorMessage);
}

class AddCompensationSuccess extends AddCompensationState {
  const AddCompensationSuccess();
}
