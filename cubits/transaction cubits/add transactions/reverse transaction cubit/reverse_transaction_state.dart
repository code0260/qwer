part of 'reverse_transaction_cubit.dart';

sealed class ReverseTransactionState extends Equatable {
  const ReverseTransactionState();

  @override
  List<Object> get props => [];
}

final class ReverseTransactionInitial extends ReverseTransactionState {}

class ReverseTransactionLoading extends ReverseTransactionState {}

class ReverseTransactionFailure extends ReverseTransactionState {
  final String errorMessage;

  const ReverseTransactionFailure(this.errorMessage);
}

class ReverseTransactionSuccess extends ReverseTransactionState {
  const ReverseTransactionSuccess();
}
