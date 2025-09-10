part of 'add_debt_cubit.dart';

sealed class AddDebtState extends Equatable {
  const AddDebtState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class AddDebtInitial extends AddDebtState {}

class AddDebtLoading extends AddDebtState {}

class AddDebtFailure extends AddDebtState {
  final String errorMessage;

  const AddDebtFailure(this.errorMessage);
}

class AddDebtSuccess extends AddDebtState {}
