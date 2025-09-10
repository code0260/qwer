part of 'edit_revenue_cubit.dart';

sealed class EditRevenuesState extends Equatable {
  const EditRevenuesState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class EditRevenuesInitial extends EditRevenuesState {}

class EditRevenuesLoading extends EditRevenuesState {}

class EditRevenuesFailure extends EditRevenuesState {
  final String errorMessage;

  const EditRevenuesFailure(this.errorMessage);
}

class EditRevenuesSuccess extends EditRevenuesState {}

class EditRevenueCurrencyChanged extends EditRevenuesState {
  final int currencyId;

  const EditRevenueCurrencyChanged({required this.currencyId});
  @override
  // TODO: implement props
  List<Object?> get props => [currencyId];
}
