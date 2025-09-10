part of 'get_sells_cubit.dart';

sealed class GetSellsState extends Equatable {
  const GetSellsState();

  @override
  List<Object> get props => [];
}

final class GetSellsInitial extends GetSellsState {}

class GetSellsLoading extends GetSellsState {}

class GetSellsFailure extends GetSellsState {
  final String errorMessage;

  const GetSellsFailure(this.errorMessage);
}

class GetSellsSuccess extends GetSellsState {
  final SellsInfoModel sellsInfoModel;
  const GetSellsSuccess({
    required this.sellsInfoModel,
  });
  @override
  // TODO: implement props
  List<Object> get props => [sellsInfoModel];
}
