import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/cash%20models/edit_cash_model.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareEditCashDamage(EditCashModel editCashModel) {
  Map data = {};
  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription = "تعديل نقدي بسبب تلف";
  double newAmount = (editCashModel.amountInBase ?? editCashModel.amount!);
  double originalAmount =
      (editCashModel.originalAmountInBase ?? editCashModel.originalAmount!);

  // $ Debit: Record the damage expense
  int accountsIdForDamageExpense =
      StoreAccounts.getAccountByCode('329009')!.accountsId!;
  var damageExpensePart = TransactionLineInputModel(
    transactionLineDebitCredit: 'Debit',
    transactionLineAmount: (originalAmount - newAmount).abs(),
    transactionLineAccountId: accountsIdForDamageExpense,
    transactionLineDescription: transactionsDescription,
  );

  // $ Credit: Reduce cash in hand
  int accountsIdForCash = StoreAccounts.getAccountByCode('121000')!.accountsId!;
  var cashPart = TransactionLineInputModel(
    transactionLineDebitCredit: 'Credit',
    transactionLineAccountId: accountsIdForCash,
    transactionLineAmount: (originalAmount - newAmount).abs(),
    transactionLineDescription: transactionsDescription,
  );

  lines.addAll([damageExpensePart, cashPart]);

  var addTransactionModel = AddTransactionModel(
    transactionModel: TransactionModel(
      transactionsCurrencyId: editCashModel.currencyId,
      transactionsDescription: transactionsDescription,
      transactionsTransactionDate: DateTime.now().toString(),
    ),
    lines: lines,
  );

  data["transaction_data"] = addTransactionModel.toMap();

  //& expense
  data['expense'] = ExpenseInputModel(
          expensesName: 'تلف نقد',
          expensesAmount:
              (editCashModel.originalAmount! - editCashModel.amount!).abs(),
          expensesAccountId: accountsIdForDamageExpense,
          expensesAmountCurrencyId: editCashModel.currencyId,
          expensesAmountInBase: editCashModel.amountInBase == null
              ? null
              : (editCashModel.originalAmountInBase! -
                      editCashModel.amountInBase!)
                  .abs())
      .toMap();

  return data;
}
