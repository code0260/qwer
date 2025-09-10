import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareExpenseData(ExpenseInputModel expenseInputModel) {
  Map data = {};
  data["expense"] = expenseInputModel.toMap();

  //$ amount
  int nearFactorBase = currencies
      .firstWhere((element) => element.businessCurrencyIsBase == 1)
      .businessCurrencyNearFactor!;
  double amount = (expenseInputModel.expensesAmountInBase ??
          expenseInputModel.expensesAmount!)
      .roundToNearest(nearFactorBase);

  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription = 'مصروف ${expenseInputModel.expensesName}';

  //$ Debit
  if (expenseInputModel.expensesType == ExpenseType.done.name) {
    int accountsIdForCash =
        StoreAccounts.getAccountByCode('121000')!.accountsId!;
    var cashPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForCash,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(cashPart); //$ Credit

    var expensePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: amount,
      transactionLineAccountId: expenseInputModel.expensesAccountId,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(expensePart);
  } else if (expenseInputModel.expensesType == ExpenseType.prepaid.name) {
    //$ Credit
    int accountsIdForCash =
        StoreAccounts.getAccountByCode('121000')!.accountsId!;
    var cashPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForCash,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(cashPart);
    //$ Debit
    int accountsIdForPrepaidExpense =
        StoreAccounts.getAccountByCode("124000")!.accountsId!;
    var prepaidExpensePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForPrepaidExpense,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(prepaidExpensePart);
  } else if (expenseInputModel.expensesType == ExpenseType.due.name) {
    //$ Credit
    int accountsIdForDueExpense =
        StoreAccounts.getAccountByCode("233003")!.accountsId!;
    var dueExpensePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForDueExpense,
      transactionLineDescription: transactionsDescription,
    );
    var expensePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: amount,
      transactionLineAccountId: expenseInputModel.expensesAccountId,
      transactionLineDescription: transactionsDescription,
    );
    lines.addAll([dueExpensePart, expensePart]);
  }

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionReferenceNumberType:
            TransactionReferenceNumberType.expense.name,
        transactionsDescription: transactionsDescription,
        transactionsCurrencyId: expenseInputModel.expensesAmountCurrencyId,
        transactionsReferenceNumber: null, // will be set in the backend
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
