part of 'add_currency_cubit.dart';

sealed class AddCurrencyState extends Equatable {
  const AddCurrencyState();

  @override
  List<Object> get props => [];
}

final class AddCurrencyInitial extends AddCurrencyState {}

class AddCurrencyLoading extends AddCurrencyState {}

class AddCurrencyFailure extends AddCurrencyState {
  final String errorMessage;

  const AddCurrencyFailure(this.errorMessage);
}

class AddCurrencySuccess extends AddCurrencyState {
  const AddCurrencySuccess();
}

class AddCurrencyChanged extends AddCurrencyState {
  final CurrencyModel currencyModel;
  const AddCurrencyChanged({required this.currencyModel});
  @override
  // TODO: implement props
  List<Object> get props => [currencyModel];
}
