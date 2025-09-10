part of 'import_prices_cubit.dart';

sealed class ImportPricesState extends Equatable {
  const ImportPricesState();

  @override
  List<Object> get props => [];
}

final class ImportPricesInitial extends ImportPricesState {}

class ImportPricesLoading extends ImportPricesState {}

class ImportPricesFailure extends ImportPricesState {
  final String errorMessage;

  const ImportPricesFailure({required this.errorMessage});
}

class ImportPricesSuccess extends ImportPricesState {}
