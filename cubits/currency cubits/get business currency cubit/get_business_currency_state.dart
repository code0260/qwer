part of 'get_business_currency_cubit.dart';

sealed class GetBusinessCurrencyState extends Equatable {
  const GetBusinessCurrencyState();

  @override
  List<Object> get props => [];
}

final class GetBusinessCurrencyInitial extends GetBusinessCurrencyState {}

class GetBusinessCurrencyLoading extends GetBusinessCurrencyState {}

class GetBusinessCurrencyFailure extends GetBusinessCurrencyState {
  final String errorMessage;

  const GetBusinessCurrencyFailure(this.errorMessage);
}

class GetBusinessCurrencySuccess extends GetBusinessCurrencyState {
  final List<CurrencyModel> currencies;
  const GetBusinessCurrencySuccess({
    required this.currencies,
  });
  @override
  // TODO: implement props
  List<Object> get props => [currencies];
}
