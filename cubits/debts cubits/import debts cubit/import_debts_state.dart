part of 'import_debts_cubit.dart';

sealed class ImportDebtsState extends Equatable {
  const ImportDebtsState();

  @override
  List<Object> get props => [];
}

final class ImportDebtsInitial extends ImportDebtsState {}

class ImportDebtsLoading extends ImportDebtsState {}

class ImportDebtsFailure extends ImportDebtsState {
  final String errorMessage;

  const ImportDebtsFailure({required this.errorMessage});
}

class ImportDebtsSuccess extends ImportDebtsState {}
