part of 'get_settings_cubit.dart';

sealed class GetSettingsState extends Equatable {
  const GetSettingsState();

  @override
  List<Object> get props => [];
}

final class GetSettingsInitial extends GetSettingsState {}

class GetSettingsLoading extends GetSettingsState {}

class GetSettingsFailure extends GetSettingsState {
  final String errorMessage;

  const GetSettingsFailure(this.errorMessage);
}

class GetSettingsSuccess extends GetSettingsState {
  final SettingsModel settingModel;
  const GetSettingsSuccess({
    required this.settingModel,
  });
}
