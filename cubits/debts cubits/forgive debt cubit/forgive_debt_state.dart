part of 'forgive_debt_cubit.dart';

sealed class ForgiveDebtState extends Equatable {
  const ForgiveDebtState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ForgiveDebtInitial extends ForgiveDebtState {}

class ForgiveDebtLoading extends ForgiveDebtState {}

class ForgiveDebtFailure extends ForgiveDebtState {
  final String errorMessage;

  const ForgiveDebtFailure(this.errorMessage);
}

class ForgiveDebtSuccess extends ForgiveDebtState {}
