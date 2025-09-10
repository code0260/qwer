part of 'import_assets_cubit.dart';

sealed class ImportAssetsState extends Equatable {
  const ImportAssetsState();

  @override
  List<Object> get props => [];
}

final class ImportAssetsInitial extends ImportAssetsState {}

class ImportAssetsLoading extends ImportAssetsState {}

class ImportAssetsFailure extends ImportAssetsState {
  final String errorMessage;

  const ImportAssetsFailure({required this.errorMessage});
}

class ImportAssetsSuccess extends ImportAssetsState {}
