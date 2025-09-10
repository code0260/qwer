part of 'get_clients_balance_cubit.dart';

sealed class GetClientsBalanceState extends Equatable {
  const GetClientsBalanceState();

  @override
  List<Object> get props => [];
}

final class GetClientsBalanceInitial extends GetClientsBalanceState {}

class GetClientsBalanceLoading extends GetClientsBalanceState {}

class GetClientsBalanceFailure extends GetClientsBalanceState {
  final String errorMessage;

  const GetClientsBalanceFailure(this.errorMessage);
}

class GetClientsBalanceSuccess extends GetClientsBalanceState {
  final List<GetClientModel> clients;
  const GetClientsBalanceSuccess({
    required this.clients,
  });
  @override
  // TODO: implement props
  List<Object> get props => [clients];
}
