part of 'import_revenues_cubit.dart';

sealed class ImportRevenuesState extends Equatable {
  const ImportRevenuesState();

  @override
  List<Object> get props => [];
}

final class ImportRevenuesInitial extends ImportRevenuesState {}

class ImportRevenuesLoading extends ImportRevenuesState {}

class ImportRevenuesFailure extends ImportRevenuesState {
  final String errorMessage;

  const ImportRevenuesFailure({required this.errorMessage});
}

class ImportRevenuesSuccess extends ImportRevenuesState {}
