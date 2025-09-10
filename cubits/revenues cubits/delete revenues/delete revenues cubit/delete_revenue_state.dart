part of 'delete_revenue_cubit.dart';

sealed class DeleteRevenueState extends Equatable {
  const DeleteRevenueState();

  @override
  List<Object> get props => [];
}

final class DeleteRevenueInitial extends DeleteRevenueState {}

class DeleteRevenueLoading extends DeleteRevenueState {}

class DeleteRevenueFailure extends DeleteRevenueState {
  final String errorMessage;

  const DeleteRevenueFailure({required this.errorMessage});
}

class DeleteRevenueSuccess extends DeleteRevenueState {}
