part of 'kill_debt_cubit.dart';

sealed class KillDebtState extends Equatable {
  const KillDebtState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class KillDebtInitial extends KillDebtState {}

class KillDebtLoading extends KillDebtState {}

class KillDebtFailure extends KillDebtState {
  final String errorMessage;

  const KillDebtFailure(this.errorMessage);
}

class KillDebtSuccess extends KillDebtState {}
