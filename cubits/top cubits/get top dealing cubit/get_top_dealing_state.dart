part of 'get_top_dealing_cubit.dart';

sealed class GetTopDealingState extends Equatable {
  const GetTopDealingState();

  @override
  List<Object> get props => [];
}

final class GetTopDealingInitial extends GetTopDealingState {}

class GetTopDealingLoading extends GetTopDealingState {}

class GetTopDealingFailure extends GetTopDealingState {
  final String errorMessage;

  const GetTopDealingFailure(this.errorMessage);
}

class GetTopDealingSuccess extends GetTopDealingState {
  final List<TopDealingModel> tops;
  const GetTopDealingSuccess({
    required this.tops,
  });
  @override
  // TODO: implement props
  List<Object> get props => [tops];
}
