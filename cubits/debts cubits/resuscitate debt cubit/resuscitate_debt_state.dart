part of 'resuscitate_debt_cubit.dart';

sealed class ResuscitateDebtState extends Equatable {
  const ResuscitateDebtState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ResuscitateDebtInitial extends ResuscitateDebtState {}

class ResuscitateDebtLoading extends ResuscitateDebtState {}

class ResuscitateDebtFailure extends ResuscitateDebtState {
  final String errorMessage;

  const ResuscitateDebtFailure(this.errorMessage);
}

class ResuscitateDebtSuccess extends ResuscitateDebtState {}
