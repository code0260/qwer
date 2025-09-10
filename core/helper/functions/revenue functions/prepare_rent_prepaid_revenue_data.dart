import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/revenues%20models/rent_prepaid_revenue_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareRentPrepaidRevenueData(
    RentPrepaidRevenueInputModel rentPrepaidRevenueInputModel) {
  Map data = {};
  data["rent_prepaid_revenue"] = rentPrepaidRevenueInputModel.toJson();
  // transaction
  double amount =
      rentPrepaidRevenueInputModel.rentPrepaidRevenuesAmountInBase ??
          rentPrepaidRevenueInputModel.rentPrepaidRevenuesAmount!;

  List<TransactionLineInputModel> lines = [];
  var transactionsDescription =
      'إنشاء إيجار مقدم: ${rentPrepaidRevenueInputModel.rentPrepaidRevenuesName}';
  //$ Debit
  int accountsIdForCash = StoreAccounts.getAccountByCode('121000')!.accountsId!;
  var cashPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForCash,
    transactionLineDescription: transactionsDescription,
  );
  //$ Credit
  var rentPrepaidRevenuePart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAmount: amount,
    transactionLineAccountId:
        rentPrepaidRevenueInputModel.rentPrepaidRevenuesAccountsId,
    transactionLineDescription: transactionsDescription,
  );

  lines.addAll([cashPart, rentPrepaidRevenuePart]);

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionsDescription: transactionsDescription,
        transactionsTransactionDate: DateTime.now().toString(),
        transactionsCurrencyId:
            rentPrepaidRevenueInputModel.rentPrepaidRevenuesAmountCurrencyId,
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
