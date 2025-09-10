part of 'import_clients_cubit.dart';

sealed class ImportClientsState extends Equatable {
  const ImportClientsState();

  @override
  List<Object> get props => [];
}

final class ImportClientsInitial extends ImportClientsState {}

class ImportClientsLoading extends ImportClientsState {}

class ImportClientsFailure extends ImportClientsState {
  final String errorMessage;

  const ImportClientsFailure({required this.errorMessage});
}

class ImportClientsSuccess extends ImportClientsState {}
