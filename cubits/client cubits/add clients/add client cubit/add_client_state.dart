part of 'add_client_cubit.dart';

sealed class AddClientState extends Equatable {
  const AddClientState();

  @override
  List<Object> get props => [];
}

final class AddClientInitial extends AddClientState {}

class AddClientLoading extends AddClientState {}

class AddClientFailure extends AddClientState {
  final String errorMessage;

  const AddClientFailure(this.errorMessage);
}

class AddClientSuccess extends AddClientState {
  const AddClientSuccess();
}
