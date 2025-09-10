part of 'get_rent_prepaid_revenues_cubit.dart';

sealed class GetRevenueRentsState extends Equatable {
  const GetRevenueRentsState();

  @override
  List<Object> get props => [];
}

final class GetRevenueRentsInitial extends GetRevenueRentsState {}

class GetRevenueRentsLoading extends GetRevenueRentsState {}

class GetRevenueRentsFailure extends GetRevenueRentsState {
  final String errorMessage;

  const GetRevenueRentsFailure(this.errorMessage);
}

class GetRevenueRentsSuccess extends GetRevenueRentsState {
  final List<RentPrepaidRevenueModel> rents;
  const GetRevenueRentsSuccess({
    required this.rents,
  });
}
