part of 'connect_usb_cubit.dart';

sealed class ConnectUSBState extends Equatable {
  const ConnectUSBState();

  @override
  List<Object> get props => [];
}

final class ConnectUSBInitial extends ConnectUSBState {}

class ConnectUSBLoading extends ConnectUSBState {}

class ConnectUSBFailure extends ConnectUSBState {
  final String errorMessage;

  const ConnectUSBFailure({required this.errorMessage});
}

class ConnectUSBSuccess extends ConnectUSBState {
  const ConnectUSBSuccess();
}
