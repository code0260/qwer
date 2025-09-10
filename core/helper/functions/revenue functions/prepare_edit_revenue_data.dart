import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/prepare_transaction_line_for_exchange.dart';
import 'package:almonazim/core/helper/functions/revenue%20functions/prepare_exchange_rate_in_due_revenue.dart';
import 'package:almonazim/core/helper/functions/revenue%20functions/prepare_exchange_rate_in_prepaid_revenue.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareEditRevenueData(
    RevenueInputModel revenueInputModel, RevenuesModel revenuesModel) {
  Map data = {};
  data["revenue"] = revenueInputModel.toMap();
  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription = '';
  double amount =
      revenueInputModel.paidThisTimeInBase ?? revenueInputModel.paidThisTime!;

  if (revenueInputModel.originalType == RevenueType.prepaid.name) {
    transactionsDescription = "تسديد من ${revenueInputModel.revenuesName}";
    //$ exchange
    double exchangeAmount =
        prepareExchangeRateInPrepaidRevenue(revenueInputModel, revenuesModel);
    TransactionLineInputModel? exchangeLine = prepareTransactionLineForExchange(
        exchangeAmount, transactionsDescription, data);
    if (exchangeLine != null) {
      lines.add(exchangeLine);
    }
    //$ Credit
    var revenuePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: amount,
      transactionLineAccountId: revenueInputModel.revenuesAccountId,
      transactionLineDescription: transactionsDescription,
    );
    //$ Credit
    int accountsIdForPrepaidRevenue =
        StoreAccounts.getAccountByCode("233005")!.accountsId!;
    var prepaidRevenuePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: (amount + exchangeAmount),
      transactionLineAccountId: accountsIdForPrepaidRevenue,
      transactionLineDescription: transactionsDescription,
    );
    lines.addAll([prepaidRevenuePart, revenuePart]);
  } else if (revenueInputModel.originalType == RevenueType.due.name) {
    transactionsDescription =
        "تحصيل إيراد مستحق ${revenueInputModel.revenuesName}";
    //$ exchange
    double exchangeAmount =
        prepareExchangeRateInDueRevenue(revenueInputModel, revenuesModel);
    TransactionLineInputModel? exchangeLine = prepareTransactionLineForExchange(
        exchangeAmount, transactionsDescription, data);
    if (exchangeLine != null) {
      lines.add(exchangeLine);
    }

    //$ Debit
    int accountsIdForCash =
        StoreAccounts.getAccountByCode('121000')!.accountsId!;
    var cashPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForCash,
      transactionLineDescription: transactionsDescription,
    );
    //$ Credit
    int accountsIdForDueRevenue =
        StoreAccounts.getAccountByCode("127000")!.accountsId!;
    var dueRevenuePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: (amount - exchangeAmount),
      transactionLineAccountId: accountsIdForDueRevenue,
      transactionLineDescription: transactionsDescription,
    );
    lines.addAll([dueRevenuePart, cashPart]);
  }

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
          transactionReferenceNumberType:
              TransactionReferenceNumberType.revenue.name,
          transactionsReferenceNumber: revenueInputModel.revenuesId,
          transactionsDescription: transactionsDescription,
          transactionsTransactionDate: DateTime.now().toString(),
          transactionsCurrencyId: revenueInputModel.paidThisTimeCurrencyId),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
