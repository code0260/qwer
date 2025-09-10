import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareRevenueData(RevenueInputModel revenueInputModel) {
  Map data = {};
  data["revenue"] = revenueInputModel.toMap();
  //$ amount
  int nearFactorBase = currencies
      .firstWhere((element) => element.businessCurrencyIsBase == 1)
      .businessCurrencyNearFactor!;
  double amount = (revenueInputModel.revenuesAmountInBase ??
          revenueInputModel.revenuesAmount!)
      .roundToNearest(nearFactorBase);

  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription = 'إيراد ${revenueInputModel.revenuesName}';

  //$ Debit
  if (revenueInputModel.revenuesType == RevenueType.done.name) {
    int accountsIdForCash =
        StoreAccounts.getAccountByCode('121000')!.accountsId!;
    var cashPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForCash,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(cashPart); //$ Credit

    var revenuePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: amount,
      transactionLineAccountId: revenueInputModel.revenuesAccountId,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(revenuePart);
  } else if (revenueInputModel.revenuesType == RevenueType.prepaid.name) {
    //$ Debit
    int accountsIdForCash =
        StoreAccounts.getAccountByCode('121000')!.accountsId!;
    var cashPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForCash,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(cashPart);
    //$ Debit
    int accountsIdForPrepaidRevenue =
        StoreAccounts.getAccountByCode("233005")!.accountsId!;
    var prepaidRevenuePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForPrepaidRevenue,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(prepaidRevenuePart);
  } else if (revenueInputModel.revenuesType == RevenueType.due.name) {
    //$ Credit
    int accountsIdForDueRevenue =
        StoreAccounts.getAccountByCode("127000")!.accountsId!;
    var dueRevenuePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForDueRevenue,
      transactionLineDescription: transactionsDescription,
    );
    var revenuePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: amount,
      transactionLineAccountId: revenueInputModel.revenuesAccountId,
      transactionLineDescription: transactionsDescription,
    );
    lines.addAll([dueRevenuePart, revenuePart]);
  }

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionReferenceNumberType:
            TransactionReferenceNumberType.revenue.name,
        transactionsDescription: transactionsDescription,
        transactionsReferenceNumber: null, // will be set in the backend
        transactionsCurrencyId: revenueInputModel.revenuesAmountCurrencyId,
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
