part of 'get_bluetooth_devices_cubit.dart';

sealed class GetBluetoothDevicesState extends Equatable {
  const GetBluetoothDevicesState();

  @override
  List<Object> get props => [];
}

final class GetBluetoothDevicesInitial extends GetBluetoothDevicesState {}

class GetBluetoothDevicesLoading extends GetBluetoothDevicesState {}

class GetBluetoothDevicesFailure extends GetBluetoothDevicesState {
  final String errorMessage;

  const GetBluetoothDevicesFailure({required this.errorMessage});
}

class GetBluetoothDevicesSuccess extends GetBluetoothDevicesState {
  final List<String> devices;

  const GetBluetoothDevicesSuccess({required this.devices});
}
