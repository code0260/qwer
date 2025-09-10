part of 'get_cash_cubit.dart';

sealed class GetCashState extends Equatable {
  const GetCashState();

  @override
  List<Object> get props => [];
}

final class GetCashInitial extends GetCashState {}

class GetCashLoading extends GetCashState {}

class GetCashFailure extends GetCashState {
  final String errorMessage;

  const GetCashFailure(this.errorMessage);
}

class GetCashSuccess extends GetCashState {
  final GetAllCashModel getAllCashModel;
  const GetCashSuccess({
    required this.getAllCashModel,
  });
  @override
  // TODO: implement props
  List<Object> get props => [getAllCashModel];
}
