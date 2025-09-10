import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/expense%20functions/prepare_expense_data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/cash%20models/transfer_model.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';

Map prepareTransferCash(TransferModel transferModel) {
  Map data = {};
  if (transferModel.feesAmount != 0) {
    ExpenseInputModel expenseInputModel = ExpenseInputModel(
        expensesName: "رسوم تحويل",
        expensesAmount: transferModel.feesAmount,
        expensesAmountCurrencyId: transferModel.fromCurrencyId,
        expensesAmountInBase: transferModel.feesAmountInBase,
        expensesType: ExpenseType.done.name,
        expensesAccountId:
            StoreAccounts.getAccountByCode('329011')!.accountsId!);
    data["fees_data"] = prepareExpenseData(expenseInputModel);
  }
  data['transfer_data'] = transferModel.toMap();
  return data;
}
