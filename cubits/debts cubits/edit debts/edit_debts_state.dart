part of 'edit_debts_cubit.dart';

sealed class EditDebtsState extends Equatable {
  const EditDebtsState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class EditDebtsInitial extends EditDebtsState {}

class EditDebtsLoading extends EditDebtsState {}

class EditDebtsFailure extends EditDebtsState {
  final String errorMessage;

  const EditDebtsFailure(this.errorMessage);
}

class EditDebtsSuccess extends EditDebtsState {}
