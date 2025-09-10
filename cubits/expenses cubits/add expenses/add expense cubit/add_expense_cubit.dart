import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/expenses%20repo/expenses_repo_imp.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_expense_state.dart';

class AddExpenseCubit extends SafeCubit<AddExpenseState> {
  AddExpenseCubit(this.expensesRepoImpl) : super(AddExpenseInitial());
  ExpensesRepoImpl expensesRepoImpl;
  ExpenseInputModel expenseInputModel =
      ExpenseInputModel(expensesCreatedAt: DateTime.now().toString());
  Future<void> addExpense() async {
    emit(AddExpenseLoading());
    prepareBaseAmount();
    var result = await expensesRepoImpl.addExpense(expenseInputModel);
    result.fold((failure) {
      emit(AddExpenseFailure(failure.errMessage));
    }, (_) {
      emit(const AddExpenseSuccess());
    });
  }

  void prepareBaseAmount() {
    if (expenseInputModel.expensesAmountCurrencyId !=
        currencies
            .firstWhere(
              (element) => element.businessCurrencyIsBase == 1,
            )
            .businessCurrencyId) {
      expenseInputModel.expensesAmountInBase = convertAmountToBase(
          expenseInputModel.expensesAmount!,
          expenseInputModel.expensesAmountCurrencyId!);
    } else {
      expenseInputModel.expensesAmountInBase = null;
    }
  }

  String? get validateDataMessage {
    if (expenseInputModel.expensesAccountId == null) {
      return "الرجاء اختيار المجموعة";
    } else if (expenseInputModel.expensesAmount == null ||
        expenseInputModel.expensesAmount == 0) {
      return "الرجاء إدخال المبلغ";
    } else if (expenseInputModel.expensesName == null ||
        expenseInputModel.expensesName!.isEmpty) {
      return "الرجاء إدخال عنوان المصروف";
    } else {
      return null;
    }
  }
}
