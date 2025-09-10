import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/expenses%20repo/expenses_repo.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_model.dart';
import 'package:equatable/equatable.dart';

part 'edit_expense_state.dart';

class EditExpensesCubit extends SafeCubit<EditExpensesState> {
  EditExpensesCubit(this.expensesRepo) : super(EditExpensesInitial());
  ExpensesRepo expensesRepo;
  ExpenseInputModel expenseInputModel = ExpenseInputModel();

  Future<void> editExpenses(ExpensesModel expensesModel) async {
    prepareCurrency();
    emit(EditExpensesLoading());
    var result =
        await expensesRepo.editExpenses(expenseInputModel, expensesModel);
    result.fold((failure) {
      emit(EditExpensesFailure(failure.errMessage));
    }, (_) {
      emit(EditExpensesSuccess());
    });
  }

  void prepareCurrency() {
    if (expenseInputModel.expensesAmountCurrencyId !=
        currencies
            .firstWhere((element) => element.businessCurrencyIsBase == 1)
            .businessCurrencyId) {
      if (expenseInputModel.expensesSecondAmount != 0) {
        expenseInputModel.paidThisTimeInBase = convertAmountToBase(
            expenseInputModel.paidThisTime!,
            expenseInputModel.paidThisTimeCurrencyId!);
        expenseInputModel.expensesSecondAmountInBase =
            (expenseInputModel.expensesSecondAmountInBase ?? 0) +
                expenseInputModel.paidThisTimeInBase!;
      }
    } else {
      expenseInputModel.expensesSecondAmountInBase = null;
      expenseInputModel.paidThisTimeInBase = null;
    }
  }

  void editCurrency(int id) {
    expenseInputModel.paidThisTimeCurrencyId = id;
    emit(EditExpenseCurrencyChanged(currencyId: id));
  }
}
