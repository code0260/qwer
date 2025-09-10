part of 'add_or_update_settings_cubit.dart';

sealed class AddOrUpdateSettingsState extends Equatable {
  const AddOrUpdateSettingsState();

  @override
  List<Object> get props => [];
}

final class AddOrUpdateSettingsInitial extends AddOrUpdateSettingsState {}

class AddOrUpdateSettingsLoading extends AddOrUpdateSettingsState {}

class AddOrUpdateSettingsFailure extends AddOrUpdateSettingsState {
  final String errorMessage;

  const AddOrUpdateSettingsFailure(this.errorMessage);
}

class AddOrUpdateSettingsSuccess extends AddOrUpdateSettingsState {
  const AddOrUpdateSettingsSuccess();
}
