part of 'edit_cash_cubit.dart';

sealed class EditCashState extends Equatable {
  const EditCashState();

  @override
  List<Object> get props => [];
}

final class EditCashInitial extends EditCashState {}

class EditCashLoading extends EditCashState {}

class EditCashFailure extends EditCashState {
  final String errorMessage;

  const EditCashFailure({required this.errorMessage});
}

class EditCashSuccess extends EditCashState {}
