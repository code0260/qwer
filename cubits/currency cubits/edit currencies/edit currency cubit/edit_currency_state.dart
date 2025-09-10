part of 'edit_currency_cubit.dart';

sealed class EditCurrencyState extends Equatable {
  const EditCurrencyState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class EditCurrencyInitial extends EditCurrencyState {}

class EditCurrencyLoading extends EditCurrencyState {}

class EditCurrencyFailure extends EditCurrencyState {
  final String errorMessage;

  const EditCurrencyFailure(this.errorMessage);
}

class EditCurrencySuccess extends EditCurrencyState {}
