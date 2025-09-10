part of 'add_transaction_cubit.dart';

sealed class AddTransactionState extends Equatable {
  const AddTransactionState();

  @override
  List<Object> get props => [];
}

final class AddTransactionInitial extends AddTransactionState {}

class AddTransactionLoading extends AddTransactionState {}

class AddTransactionFailure extends AddTransactionState {
  final String errorMessage;

  const AddTransactionFailure(this.errorMessage);
}

class AddTransactionSuccess extends AddTransactionState {
  const AddTransactionSuccess();
}
