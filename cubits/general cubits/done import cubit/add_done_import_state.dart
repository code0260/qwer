part of 'add_done_import_cubit.dart';

sealed class DoneImportDataState extends Equatable {
  const DoneImportDataState();

  @override
  List<Object> get props => [];
}

final class DoneImportDataInitial extends DoneImportDataState {}

class DoneImportDataLoading extends DoneImportDataState {}

class DoneImportDataFailure extends DoneImportDataState {
  final String errorMessage;

  const DoneImportDataFailure(this.errorMessage);
}

class DoneImportDataSuccess extends DoneImportDataState {
  const DoneImportDataSuccess();
}
