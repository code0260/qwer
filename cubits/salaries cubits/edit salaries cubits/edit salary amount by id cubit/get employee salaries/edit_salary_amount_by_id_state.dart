part of 'edit_salary_amount_by_id_cubit.dart';

sealed class EditSalaryAmountByIdState extends Equatable {
  const EditSalaryAmountByIdState();

  @override
  List<Object> get props => [];
}

final class EditSalaryAmountByIdInitial extends EditSalaryAmountByIdState {}

class EditSalaryAmountByIdLoading extends EditSalaryAmountByIdState {}

class EditSalaryAmountByIdFailure extends EditSalaryAmountByIdState {
  final String errorMessage;

  const EditSalaryAmountByIdFailure(this.errorMessage);
}

class EditSalaryAmountByIdSuccess extends EditSalaryAmountByIdState {
  const EditSalaryAmountByIdSuccess();
}
