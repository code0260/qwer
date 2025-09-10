part of 'get_currency_cubit.dart';

sealed class GetCurrencyState extends Equatable {
  const GetCurrencyState();

  @override
  List<Object> get props => [];
}

final class GetCurrencyInitial extends GetCurrencyState {}

class GetCurrencyLoading extends GetCurrencyState {}

class GetCurrencyFailure extends GetCurrencyState {
  final String errorMessage;

  const GetCurrencyFailure(this.errorMessage);
}

class GetCurrencySuccess extends GetCurrencyState {
  final List<CurrencyModel> currencies;
  const GetCurrencySuccess({
    required this.currencies,
  });
  @override
  // TODO: implement props
  List<Object> get props => [currencies];
}
