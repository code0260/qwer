part of 'get_bought_cubit.dart';

sealed class GetBoughtState extends Equatable {
  const GetBoughtState();

  @override
  List<Object> get props => [];
}

final class GetBoughtInitial extends GetBoughtState {}

class GetBoughtLoading extends GetBoughtState {}

class GetBoughtFailure extends GetBoughtState {
  final String errorMessage;

  const GetBoughtFailure(this.errorMessage);
}

class GetBoughtSuccess extends GetBoughtState {
  final BoughtInfoModel boughtInfoModel;
  const GetBoughtSuccess({
    required this.boughtInfoModel,
  });
  @override
  // TODO: implement props
  List<Object> get props => [boughtInfoModel];
}
