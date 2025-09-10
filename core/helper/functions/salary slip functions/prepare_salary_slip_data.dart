import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/expense%20functions/prepare_expense_data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/salary%20slip%20models/salary_slip_model.dart';

Map prepareSalarySlipData(SalarySlipModel salarySlipModel) {
  ExpenseInputModel expenseInputModel = ExpenseInputModel(
      expensesName: "راتب ${salarySlipModel.employeesName}",
      expensesAmount: salarySlipModel.salarySlipNetSalary,
      expensesAmountCurrencyId: salarySlipModel.salarySlipAmountCurrencyId,
      expensesAmountInBase: salarySlipModel.salarySlipNetSalaryInBase,
      expensesType: ExpenseType.done.name,
      expensesAccountId: StoreAccounts.getAccountByCode('321000')!.accountsId!);
  Map data = prepareExpenseData(expenseInputModel);
  data["salarySlip"] = salarySlipModel.toMap();
  return data;
}
