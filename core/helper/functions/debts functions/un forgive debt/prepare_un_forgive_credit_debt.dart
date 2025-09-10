import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare_edit_transaction.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareUnForgiveCreditDebt(EditDebtModel editDebtModel) {
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
  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription =
      "إلغاء مسامحة دين ${editDebtModel.clientsName ?? editDebtModel.debtsPersonName}";
  // Debit: Based on type
  prepareEditTransaction(editDebtModel, amount, transactionsDescription, lines,
      'Credit', StoreAccounts.getAccountByCode("232000")!.accountsId!);

  //$ Debit
  var revenuePart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: amount,
    transactionLineAccountId:
        StoreAccounts.getAccountByCode('421005')!.accountsId!,
    transactionLineDescription: transactionsDescription,
  );
  lines.add(revenuePart);

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionReferenceNumberType:
            TransactionReferenceNumberType.revenue.name,
        transactionsDescription: transactionsDescription,
        transactionsReferenceNumber: null, // will be set in the backend
        transactionsCurrencyId: editDebtModel.debtsAmountCurrencyId,
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
