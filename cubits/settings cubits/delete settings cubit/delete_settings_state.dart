part of 'delete_settings_cubit.dart';

sealed class DeleteSettingsState extends Equatable {
  const DeleteSettingsState();

  @override
  List<Object> get props => [];
}

final class DeleteSettingsInitial extends DeleteSettingsState {}

class DeleteSettingsLoading extends DeleteSettingsState {}

class DeleteSettingsFailure extends DeleteSettingsState {
  final String errorMessage;

  const DeleteSettingsFailure(this.errorMessage);
}

class DeleteSettingsSuccess extends DeleteSettingsState {}
