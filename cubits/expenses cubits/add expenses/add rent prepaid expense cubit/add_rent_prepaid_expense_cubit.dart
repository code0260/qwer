import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/repo/expenses%20repo/expenses_repo_imp.dart';
import 'package:almonazim/data/model/expenses%20models/rent_prepaid_expense_input_model.dart';
import 'package:equatable/equatable.dart';

part 'add_rent_prepaid_expense_state.dart';

class AddRentPrepaidExpenseCubit extends SafeCubit<AddRentPrepaidExpenseState> {
  AddRentPrepaidExpenseCubit(this.expensesRepoImpl)
      : super(AddRentPrepaidExpenseInitial());

  final ExpensesRepoImpl expensesRepoImpl;
  RentPrepaidExpenseInputModel rentPrepaidExpenseInputModel =
      RentPrepaidExpenseInputModel(
          rentPrepaidExpensesCreatedAt: DateTime.now().toString());

  Future<void> addRentPrepaidExpense() async {
    prepareBaseAmount();
    emit(AddRentPrepaidExpenseLoading());
    var result = await expensesRepoImpl
        .addRentPrepaidExpense(rentPrepaidExpenseInputModel);
    result.fold((failure) {
      emit(AddRentPrepaidExpenseFailure(failure.errMessage));
    }, (_) {
      emit(const AddRentPrepaidExpenseSuccess());
    });
  }

  void prepareBaseAmount() {
    if (rentPrepaidExpenseInputModel.rentPrepaidExpensesAmountCurrencyId !=
        currencies
            .firstWhere(
              (element) => element.businessCurrencyIsBase == 1,
            )
            .businessCurrencyId) {
      rentPrepaidExpenseInputModel.rentPrepaidExpensesAmountInBase =
          convertAmountToBase(
              rentPrepaidExpenseInputModel.rentPrepaidExpensesAmount!,
              rentPrepaidExpenseInputModel
                  .rentPrepaidExpensesAmountCurrencyId!);
    } else {
      rentPrepaidExpenseInputModel.rentPrepaidExpensesAmountInBase = null;
    }
  }

  String? get validateDataMessage {
    if (rentPrepaidExpenseInputModel.rentPrepaidExpensesAccountsId == null) {
      return "الرجاء اختيار الحساب";
    } else if (rentPrepaidExpenseInputModel.rentPrepaidExpensesAmount == null ||
        rentPrepaidExpenseInputModel.rentPrepaidExpensesAmount == 0) {
      return "الرجاء إدخال المبلغ";
    } else if (rentPrepaidExpenseInputModel.rentPrepaidExpensesName == null ||
        rentPrepaidExpenseInputModel.rentPrepaidExpensesName!.isEmpty) {
      return "الرجاء إدخال اسم المصروف المدفوع مقدماً";
    } else if (rentPrepaidExpenseInputModel.rentPrepaidExpensesMonthCount ==
        null) {
      return "الرجاء إدخال عدد الأشهر";
    } else if (rentPrepaidExpenseInputModel.rentPrepaidExpensesStartDate ==
            null ||
        rentPrepaidExpenseInputModel.rentPrepaidExpensesStartDate!.isEmpty) {
      return "الرجاء اختيار تاريخ البداية";
    } else {
      return null;
    }
  }
}
