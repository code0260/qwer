part of 'get_usb_devices_cubit.dart';

sealed class GetUSBDevicesState extends Equatable {
  const GetUSBDevicesState();

  @override
  List<Object> get props => [];
}

final class GetUSBDevicesInitial extends GetUSBDevicesState {}

class GetUSBDevicesLoading extends GetUSBDevicesState {}

class GetUSBDevicesFailure extends GetUSBDevicesState {
  final String errorMessage;

  const GetUSBDevicesFailure({required this.errorMessage});
}

class GetUSBDevicesSuccess extends GetUSBDevicesState {
  final List<String> devices;

  const GetUSBDevicesSuccess({required this.devices});
}
