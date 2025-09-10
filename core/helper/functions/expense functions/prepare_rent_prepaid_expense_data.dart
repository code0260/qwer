import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/expenses%20models/rent_prepaid_expense_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareRentPrepaidExpenseData(
    RentPrepaidExpenseInputModel rentPrepaidExpenseInputModel) {
  Map data = {};
  data["rent_prepaid_expense"] = rentPrepaidExpenseInputModel.toJson();
  // transaction
  double amount =
      rentPrepaidExpenseInputModel.rentPrepaidExpensesAmountInBase ??
          rentPrepaidExpenseInputModel.rentPrepaidExpensesAmount!;
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription =
      'إنشاء إيجار مقدم: ${rentPrepaidExpenseInputModel.rentPrepaidExpensesName}';
  //$ Credit
  int accountsIdForCash = StoreAccounts.getAccountByCode('121000')!.accountsId!;
  var cashPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForCash,
    transactionLineDescription: transactionsDescription,
  );
  //$ Debit
  var rentPrepaidExpensePart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: amount,
    transactionLineAccountId:
        rentPrepaidExpenseInputModel.rentPrepaidExpensesAccountsId,
    transactionLineDescription: transactionsDescription,
  );

  lines.addAll([cashPart, rentPrepaidExpensePart]);

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionsDescription: transactionsDescription,
        transactionsCurrencyId:
            rentPrepaidExpenseInputModel.rentPrepaidExpensesAmountCurrencyId,
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
