part of 'transfer_cubit.dart';

sealed class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object> get props => [];
}

final class TransferInitial extends TransferState {}

class TransferLoading extends TransferState {}

class TransferFailure extends TransferState {
  final String errorMessage;

  const TransferFailure(this.errorMessage);
}

class TransferSuccess extends TransferState {
  const TransferSuccess();
}

class TransferDataChanged extends TransferState {
  final TransferModel transferModel;
  const TransferDataChanged({required this.transferModel});

  @override
  // TODO: implement props
  List<Object> get props => [transferModel];
}
