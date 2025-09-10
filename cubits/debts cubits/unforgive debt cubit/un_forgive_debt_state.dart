part of 'un_forgive_debt_cubit.dart';

sealed class UnForgiveDebtState extends Equatable {
  const UnForgiveDebtState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class UnForgiveDebtInitial extends UnForgiveDebtState {}

class UnForgiveDebtLoading extends UnForgiveDebtState {}

class UnForgiveDebtFailure extends UnForgiveDebtState {
  final String errorMessage;

  const UnForgiveDebtFailure(this.errorMessage);
}

class UnForgiveDebtSuccess extends UnForgiveDebtState {}
