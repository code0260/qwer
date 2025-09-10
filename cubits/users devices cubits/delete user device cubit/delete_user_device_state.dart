part of 'delete_user_device_units_cubit.dart';

sealed class DeleteUserDeviceState extends Equatable {
  const DeleteUserDeviceState();

  @override
  List<Object> get props => [];
}

final class DeleteUserDeviceInitial extends DeleteUserDeviceState {}

class DeleteUserDeviceLoading extends DeleteUserDeviceState {}

class DeleteUserDeviceFailure extends DeleteUserDeviceState {
  final String errorMessage;

  const DeleteUserDeviceFailure(this.errorMessage);
}

class DeleteUserDeviceSuccess extends DeleteUserDeviceState {}
