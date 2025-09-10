part of 'connect_bluetooth_cubit.dart';

sealed class ConnectBluetoothState extends Equatable {
  const ConnectBluetoothState();

  @override
  List<Object> get props => [];
}

final class ConnectBluetoothInitial extends ConnectBluetoothState {}

class ConnectBluetoothLoading extends ConnectBluetoothState {}

class ConnectBluetoothFailure extends ConnectBluetoothState {
  final String errorMessage;

  const ConnectBluetoothFailure({required this.errorMessage});
}

class ConnectBluetoothSuccess extends ConnectBluetoothState {
  const ConnectBluetoothSuccess();
}
