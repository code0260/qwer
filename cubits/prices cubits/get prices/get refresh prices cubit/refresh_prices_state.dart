part of 'refresh_prices_cubit.dart';

sealed class RefreshPriceState extends Equatable {
  const RefreshPriceState();

  @override
  List<Object> get props => [];
}

final class RefreshPriceInitial extends RefreshPriceState {}

class RefreshPriceLoading extends RefreshPriceState {}

class RefreshPriceFailure extends RefreshPriceState {
  final String errorMessage;

  const RefreshPriceFailure(this.errorMessage);
}

class RefreshPriceSuccess extends RefreshPriceState {}
