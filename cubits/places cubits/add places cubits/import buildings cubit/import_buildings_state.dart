part of 'import_buildings_cubit.dart';

sealed class ImportBuildingsState extends Equatable {
  const ImportBuildingsState();

  @override
  List<Object> get props => [];
}

final class ImportBuildingsInitial extends ImportBuildingsState {}

class ImportBuildingsLoading extends ImportBuildingsState {}

class ImportBuildingsFailure extends ImportBuildingsState {
  final String errorMessage;

  const ImportBuildingsFailure({required this.errorMessage});
}

class ImportBuildingsSuccess extends ImportBuildingsState {}
