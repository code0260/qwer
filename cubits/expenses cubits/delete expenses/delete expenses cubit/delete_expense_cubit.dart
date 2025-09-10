import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data/data%20source/repo/expenses%20repo/expenses_repo_imp.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:equatable/equatable.dart';

part 'delete_expense_state.dart';

class DeleteExpenseCubit extends SafeCubit<DeleteExpenseState> {
  DeleteExpenseCubit(this.expenseRepo) : super(DeleteExpenseInitial());
  ExpensesRepoImpl expenseRepo;
  Future<void> deleteExpense(ExpenseInputModel expenseInputModel) async {
    emit(DeleteExpenseLoading());
    var result = await expenseRepo.deleteExpense(expenseInputModel);
    result.fold((failure) {
      emit(DeleteExpenseFailure(errorMessage: failure.errMessage));
    }, (message) {
      emit(DeleteExpenseSuccess());
    });
  }
}
