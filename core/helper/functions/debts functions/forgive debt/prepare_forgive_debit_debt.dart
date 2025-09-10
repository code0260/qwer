import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare_edit_transaction.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareForgiveDebitDebt(EditDebtModel editDebtModel) {
  Map data = {};
  data["debt"] = editDebtModel.toMap();

  // Get amount
  int nearFactorBase = currencies
      .firstWhere((element) => element.businessCurrencyIsBase == 1)
      .businessCurrencyNearFactor!;
  double amount = (editDebtModel.debtsTotalAmountInBase ??
          editDebtModel.debtsTotalAmount!) -
      (editDebtModel.debtsPaidAmountInBase ?? editDebtModel.paidAmount!)
          .roundToNearest(nearFactorBase);

  double amountInBase =
      convertAmountToBase(amount, editDebtModel.debtsAmountCurrencyId!);

  // Prepare expense input model
  var expenseInputModel = ExpenseInputModel(
      expensesName:
          " مسامحة دين ${editDebtModel.clientsName ?? editDebtModel.debtsPersonName}",
      expensesAmount: amount,
      expensesAccountId: StoreAccounts.getAccountByCode('329012')!.accountsId!,
      expensesAmountCurrencyId: editDebtModel.debtsAmountCurrencyId,
      expensesType: ExpenseType.done.name,
      expensesDescription: "مصروف مسامحة دين رقم ${editDebtModel.debtsId}#",
      expensesAmountInBase: amountInBase == amount ? null : amountInBase);

  data['expense'] = expenseInputModel.toMap();

  // Prepare transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription = 'مصروف ${expenseInputModel.expensesName}';

  // Credit: Based on type
  prepareEditTransaction(editDebtModel, amount, transactionsDescription, lines,
      'Credit', StoreAccounts.getAccountByCode("125004")!.accountsId!);

  // Debit: Expense account
  var expensePart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: amount,
    transactionLineAccountId: expenseInputModel.expensesAccountId,
    transactionLineDescription: transactionsDescription,
  );
  lines.add(expensePart);

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionReferenceNumberType:
            TransactionReferenceNumberType.expense.name,
        transactionsDescription: transactionsDescription,
        transactionsReferenceNumber: null, // set by backend
        transactionsCurrencyId: expenseInputModel.expensesAmountCurrencyId,
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);

  data["transaction_data"] = addTransactionModel.toMap();

  return data;
}
