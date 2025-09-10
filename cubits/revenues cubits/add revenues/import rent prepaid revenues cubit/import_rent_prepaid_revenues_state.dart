part of 'import_rent_prepaid_revenues_cubit.dart';

sealed class ImportRentPrepaidRevenuesState extends Equatable {
  const ImportRentPrepaidRevenuesState();

  @override
  List<Object> get props => [];
}

final class ImportRentPrepaidRevenuesInitial
    extends ImportRentPrepaidRevenuesState {}

class ImportRentPrepaidRevenuesLoading extends ImportRentPrepaidRevenuesState {}

class ImportRentPrepaidRevenuesFailure extends ImportRentPrepaidRevenuesState {
  final String errorMessage;

  const ImportRentPrepaidRevenuesFailure({required this.errorMessage});
}

class ImportRentPrepaidRevenuesSuccess extends ImportRentPrepaidRevenuesState {}
