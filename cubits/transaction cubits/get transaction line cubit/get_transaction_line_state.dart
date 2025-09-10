part of 'get_transaction_line_cubit.dart';

sealed class GetTransactionLineState extends Equatable {
  const GetTransactionLineState();

  @override
  List<Object> get props => [];
}

final class GetTransactionLineInitial extends GetTransactionLineState {}

class GetTransactionLineLoading extends GetTransactionLineState {}

class GetTransactionLineFailure extends GetTransactionLineState {
  final String errorMessage;

  const GetTransactionLineFailure(this.errorMessage);
}

class GetTransactionLineSuccess extends GetTransactionLineState {
  final List<TransactionLineModel> transactionLines;
  const GetTransactionLineSuccess({
    required this.transactionLines,
  });
  @override
  // TODO: implement props
  List<Object> get props => [transactionLines];
}
