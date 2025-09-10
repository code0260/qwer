part of 'general_ledger_cubit.dart';

sealed class GeneralLedgerState extends Equatable {
  const GeneralLedgerState();

  @override
  List<Object> get props => [];
}

final class GeneralLedgerInitial extends GeneralLedgerState {}

class GeneralLedgerLoading extends GeneralLedgerState {}

class GeneralLedgerFailure extends GeneralLedgerState {
  final String errorMessage;

  const GeneralLedgerFailure(this.errorMessage);
}

class GeneralLedgerSuccess extends GeneralLedgerState {
  final GeneralLedgerModel generalLedgerModel;

  const GeneralLedgerSuccess({required this.generalLedgerModel});
}
