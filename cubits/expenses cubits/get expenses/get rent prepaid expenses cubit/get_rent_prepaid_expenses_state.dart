part of 'get_rent_prepaid_expenses_cubit.dart';

sealed class GetExpenseRentsState extends Equatable {
  const GetExpenseRentsState();

  @override
  List<Object> get props => [];
}

final class GetExpenseRentsInitial extends GetExpenseRentsState {}

class GetExpenseRentsLoading extends GetExpenseRentsState {}

class GetExpenseRentsFailure extends GetExpenseRentsState {
  final String errorMessage;

  const GetExpenseRentsFailure(this.errorMessage);
}

class GetExpenseRentsSuccess extends GetExpenseRentsState {
  final List<RentPrepaidExpenseModel> rents;
  const GetExpenseRentsSuccess({
    required this.rents,
  });
}
