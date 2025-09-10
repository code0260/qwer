part of 'get_expenses_cubit.dart';

sealed class GetExpensesState extends Equatable {
  const GetExpensesState();

  @override
  List<Object> get props => [];
}

final class GetExpensesInitial extends GetExpensesState {}

class GetExpensesLoading extends GetExpensesState {}

class GetExpensesFailure extends GetExpensesState {
  final String errorMessage;

  const GetExpensesFailure(this.errorMessage);
}

class GetExpensesSuccess extends GetExpensesState {
  final GetExpensesModel getExpensesModel;
  const GetExpensesSuccess({
    required this.getExpensesModel,
  });
}
