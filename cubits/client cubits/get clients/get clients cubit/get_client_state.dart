part of 'get_client_cubit.dart';

sealed class GetClientState extends Equatable {
  const GetClientState();

  @override
  List<Object> get props => [];
}

final class GetClientInitial extends GetClientState {}

class GetClientLoading extends GetClientState {}

class GetClientFailure extends GetClientState {
  final String errorMessage;

  const GetClientFailure(this.errorMessage);
}

class GetClientSuccess extends GetClientState {
  final List<ClientModel> clients;
  const GetClientSuccess({
    required this.clients,
  });
  @override
  // TODO: implement props
  List<Object> get props => [clients];
}
