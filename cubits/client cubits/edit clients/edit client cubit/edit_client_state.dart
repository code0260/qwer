part of 'edit_client_cubit.dart';

sealed class EditClientState extends Equatable {
  const EditClientState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class EditClientInitial extends EditClientState {}

class EditClientLoading extends EditClientState {}

class EditClientFailure extends EditClientState {
  final String errorMessage;

  const EditClientFailure(this.errorMessage);
}

class EditClientSuccess extends EditClientState {}
