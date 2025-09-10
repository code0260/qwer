part of 'add_rent_prepaid_revenue_cubit.dart';

sealed class AddRentPrepaidRevenueState extends Equatable {
  const AddRentPrepaidRevenueState();

  @override
  List<Object> get props => [];
}

final class AddRentPrepaidRevenueInitial extends AddRentPrepaidRevenueState {}

class AddRentPrepaidRevenueLoading extends AddRentPrepaidRevenueState {}

class AddRentPrepaidRevenueFailure extends AddRentPrepaidRevenueState {
  final String errorMessage;

  const AddRentPrepaidRevenueFailure(this.errorMessage);
}

class AddRentPrepaidRevenueSuccess extends AddRentPrepaidRevenueState {
  const AddRentPrepaidRevenueSuccess();
}
