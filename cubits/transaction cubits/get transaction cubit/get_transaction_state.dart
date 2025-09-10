part of 'get_transaction_cubit.dart';

sealed class GetTransactionState extends Equatable {
  const GetTransactionState();

  @override
  List<Object> get props => [];
}

final class GetTransactionInitial extends GetTransactionState {}

class GetTransactionLoading extends GetTransactionState {}

class GetTransactionFailure extends GetTransactionState {
  final String errorMessage;

  const GetTransactionFailure(this.errorMessage);
}

class GetTransactionSuccess extends GetTransactionState {}
