part of 'get_latest_version_cubit.dart';

sealed class GetLatestVersionState {
  const GetLatestVersionState();
}

final class GetLatestVersionInitial extends GetLatestVersionState {}

class GetLatestVersionLoading extends GetLatestVersionState {}

class GetLatestVersionFailure extends GetLatestVersionState {
  final String errorMessage;

  const GetLatestVersionFailure(this.errorMessage);
}

class GetLatestVersionSuccess extends GetLatestVersionState {
  final String latestVersion;
  GetLatestVersionSuccess({required this.latestVersion});
}
