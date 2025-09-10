part of 'get_prices_cubit.dart';

sealed class GetPricesState extends Equatable {
  const GetPricesState();

  @override
  List<Object> get props => [];
}

final class GetPricesInitial extends GetPricesState {}

class GetPricesLoading extends GetPricesState {}

class GetPricesFailure extends GetPricesState {
  final String errorMessage;

  const GetPricesFailure(this.errorMessage);
}

class GetPricesSuccess extends GetPricesState {
  final AllPricesModel allPricesModel;
  const GetPricesSuccess({
    required this.allPricesModel,
  });
  @override
  // TODO: implement props
  List<Object> get props => [allPricesModel];
}
