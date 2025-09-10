part of 'import_employees_cubit.dart';

sealed class ImportEmployeesState extends Equatable {
  const ImportEmployeesState();

  @override
  List<Object> get props => [];
}

final class ImportEmployeesInitial extends ImportEmployeesState {}

class ImportEmployeesLoading extends ImportEmployeesState {}

class ImportEmployeesFailure extends ImportEmployeesState {
  final String errorMessage;

  const ImportEmployeesFailure({required this.errorMessage});
}

class ImportEmployeesSuccess extends ImportEmployeesState {}
