part of 'import_salaries_cubit.dart';

sealed class ImportSalariesState extends Equatable {
  const ImportSalariesState();

  @override
  List<Object> get props => [];
}

final class ImportSalariesInitial extends ImportSalariesState {}

class ImportSalariesLoading extends ImportSalariesState {}

class ImportSalariesFailure extends ImportSalariesState {
  final String errorMessage;

  const ImportSalariesFailure({required this.errorMessage});
}

class ImportSalariesSuccess extends ImportSalariesState {}
