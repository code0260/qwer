part of 'get_client_with_partners_cubit.dart';

sealed class GetClientsWithPartnersState extends Equatable {
  const GetClientsWithPartnersState();

  @override
  List<Object> get props => [];
}

final class GetClientsWithPartnersInitial extends GetClientsWithPartnersState {}

class GetClientsWithPartnersLoading extends GetClientsWithPartnersState {}

class GetClientsWithPartnersFailure extends GetClientsWithPartnersState {
  final String errorMessage;

  const GetClientsWithPartnersFailure(this.errorMessage);
}

class GetClientsWithPartnersSuccess extends GetClientsWithPartnersState {
  final List<ClientModel> clientsWithPartners;
  const GetClientsWithPartnersSuccess({
    required this.clientsWithPartners,
  });
  @override
  // TODO: implement props
  List<Object> get props => [clientsWithPartners];
}
