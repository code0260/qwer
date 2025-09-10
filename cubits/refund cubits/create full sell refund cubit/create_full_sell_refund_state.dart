part of 'create_full_sell_refund_cubit.dart';

sealed class CreateFullSellRefundState {
  const CreateFullSellRefundState();
}

final class CreateFullSellRefundInitial extends CreateFullSellRefundState {}

class CreateFullSellRefundLoading extends CreateFullSellRefundState {}

class CreateFullSellRefundFailure extends CreateFullSellRefundState {
  final String errorMessage;

  const CreateFullSellRefundFailure(this.errorMessage);
}

class CreateFullSellRefundSuccess extends CreateFullSellRefundState {}
