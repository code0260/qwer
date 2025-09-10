part of 'add_revenue_cubit.dart';

sealed class AddRevenueState extends Equatable {
  const AddRevenueState();

  @override
  List<Object> get props => [];
}

final class AddRevenueInitial extends AddRevenueState {}

class AddRevenueLoading extends AddRevenueState {}

class AddRevenueFailure extends AddRevenueState {
  final String errorMessage;

  const AddRevenueFailure(this.errorMessage);
}

class AddRevenueSuccess extends AddRevenueState {
  const AddRevenueSuccess();
}
