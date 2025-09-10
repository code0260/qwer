part of 'add_cash_cubit.dart';

sealed class AddCashState extends Equatable {
  const AddCashState();

  @override
  List<Object> get props => [];
}

final class AddCashInitial extends AddCashState {}

class AddCashLoading extends AddCashState {}

class AddCashFailure extends AddCashState {
  final String errorMessage;

  const AddCashFailure({required this.errorMessage});
}

class AddCashSuccess extends AddCashState {}
