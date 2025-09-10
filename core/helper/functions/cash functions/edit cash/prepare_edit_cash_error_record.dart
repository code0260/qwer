import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/cash%20models/edit_cash_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareEditCashErrorRecord(EditCashModel editCashModel) {
  Map data = {};

  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription = "تعديل مبلغ نقدي";
  double newAmount = (editCashModel.amountInBase ?? editCashModel.amount!);
  double originalAmount =
      (editCashModel.originalAmountInBase ?? editCashModel.originalAmount!);

  // $ Credit or Debit based on newAmount compared to originalAmount
  int accountsIdForCash = StoreAccounts.getAccountByCode('121000')!.accountsId!;
  var cashPart = TransactionLineInputModel(
    transactionLineDebitCredit: originalAmount < newAmount ? "Debit" : "Credit",
    transactionLineAccountId: accountsIdForCash,
    transactionLineAmount: (originalAmount - newAmount).abs(),
    transactionLineDescription: transactionsDescription,
  );

  // $ Debit or Credit Capital
  int accountForCashAdjustment = 0;
  if (originalAmount < newAmount) {
    accountForCashAdjustment =
        StoreAccounts.getAccountByCode('421007')!.accountsId!;
  } else {
    accountForCashAdjustment =
        StoreAccounts.getAccountByCode('341003')!.accountsId!;
  }
  var capitalPart = TransactionLineInputModel(
    transactionLineDebitCredit: originalAmount < newAmount ? "Credit" : "Debit",
    transactionLineAccountId: accountForCashAdjustment,
    transactionLineAmount: (originalAmount - newAmount).abs(),
    transactionLineDescription: transactionsDescription,
  );

  lines.addAll([cashPart, capitalPart]);

  var addTransactionModel = AddTransactionModel(
    transactionModel: TransactionModel(
      transactionsCurrencyId: editCashModel.currencyId,
      transactionsDescription: transactionsDescription,
      transactionsTransactionDate: DateTime.now().toString(),
    ),
    lines: lines,
  );

  data["transaction_data"] = addTransactionModel.toMap();

  return data;
}
