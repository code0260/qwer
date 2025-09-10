part of 'refresh_stored_data_cubit.dart';

sealed class RefreshStoredDataState extends Equatable {
  const RefreshStoredDataState();

  @override
  List<Object> get props => [];
}

final class RefreshStoredDataInitial extends RefreshStoredDataState {}

class RefreshStoredDataLoading extends RefreshStoredDataState {}

class RefreshStoredDataFailure extends RefreshStoredDataState {
  final String errorMessage;

  const RefreshStoredDataFailure(this.errorMessage);
}

class RefreshStoredDataSuccess extends RefreshStoredDataState {}
