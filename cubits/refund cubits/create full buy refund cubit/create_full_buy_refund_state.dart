part of 'create_full_buy_refund_cubit.dart';

sealed class CreateFullBuyRefundState {
  const CreateFullBuyRefundState();
}

final class CreateFullBuyRefundInitial extends CreateFullBuyRefundState {}

class CreateFullBuyRefundLoading extends CreateFullBuyRefundState {}

class CreateFullBuyRefundFailure extends CreateFullBuyRefundState {
  final String errorMessage;

  const CreateFullBuyRefundFailure(this.errorMessage);
}

class CreateFullBuyRefundSuccess extends CreateFullBuyRefundState {}
