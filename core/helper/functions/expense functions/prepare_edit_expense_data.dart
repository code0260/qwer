import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/prepare_transaction_line_for_exchange.dart';
import 'package:almonazim/core/helper/functions/expense%20functions/prepare_exchange_rate_in_due_expense.dart';
import 'package:almonazim/core/helper/functions/expense%20functions/prepare_exchange_rate_in_prepaid_expense.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareEditExpenseData(
    ExpenseInputModel expenseInputModel, ExpensesModel expensesModel) {
  Map data = {};
  data["expense"] = expenseInputModel.toMap();
  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription = '';
  double amount =
      expenseInputModel.paidThisTimeInBase ?? expenseInputModel.paidThisTime!;
  if (expenseInputModel.originalType == ExpenseType.prepaid.name) {
    //$ exchange
    double exchangeAmount =
        prepareExchangeRateInPrepaidExpense(expenseInputModel, expensesModel);
    TransactionLineInputModel? exchangeLine = prepareTransactionLineForExchange(
        exchangeAmount, transactionsDescription, data);
    if (exchangeLine != null) {
      lines.add(exchangeLine);
    }

    transactionsDescription = "تحصيل من ${expenseInputModel.expensesName}";
    //$ Debit
    var expensePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: amount,
      transactionLineAccountId: expenseInputModel.expensesAccountId,
      transactionLineDescription: transactionsDescription,
    );
    //$ Credit
    int accountsIdForPrepaidExpense =
        StoreAccounts.getAccountByCode("124000")!.accountsId!;
    var prepaidExpensePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: (amount - exchangeAmount),
      transactionLineAccountId: accountsIdForPrepaidExpense,
      transactionLineDescription: transactionsDescription,
    );
    lines.addAll([prepaidExpensePart, expensePart]);
  } else if (expenseInputModel.originalType == ExpenseType.due.name) {
    //$ exchange
    double exchangeAmount =
        prepareExchangeRateInDueExpense(expenseInputModel, expensesModel);
    TransactionLineInputModel? exchangeLine = prepareTransactionLineForExchange(
        exchangeAmount, transactionsDescription, data);
    if (exchangeLine != null) {
      lines.add(exchangeLine);
    }

    transactionsDescription =
        "تسديد مصروف مستحق ${expenseInputModel.expensesName}";
    //$ Credit
    int accountsIdForCash =
        StoreAccounts.getAccountByCode('121000')!.accountsId!;
    var cashPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForCash,
      transactionLineDescription: transactionsDescription,
    );
    //$ Debit
    int accountsIdForDueExpense =
        StoreAccounts.getAccountByCode("233003")!.accountsId!;
    var dueExpensePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: (amount + exchangeAmount),
      transactionLineAccountId: accountsIdForDueExpense,
      transactionLineDescription: transactionsDescription,
    );
    lines.addAll([dueExpensePart, cashPart]);
  }

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionReferenceNumberType:
            TransactionReferenceNumberType.expense.name,
        transactionsReferenceNumber: expenseInputModel.expensesId,
        transactionsDescription: transactionsDescription,
        transactionsCurrencyId: expenseInputModel.paidThisTimeCurrencyId,
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
