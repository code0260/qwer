import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/cash%20models/cash_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareAddCashTransaction(CashInputModel cashModel) {
  Map data = {};
  double cashAmount = convertAmountToBase(
      cashModel.cashAmount!, cashModel.cashAmountCurrencyId!);
  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription =
      "القيد الافتتاحي: إضافة النقد ب${currencies.firstWhere((element) => element.businessCurrencyId == cashModel.cashAmountCurrencyId!).currenciesNameAr}";
  //$ Debit
  int? accountsIdForCash = StoreAccounts.getAccountByCode('121000')?.accountsId;
  var cashPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: cashAmount,
    transactionLineAccountId: accountsIdForCash,
    transactionLineDescription: transactionsDescription,
  );
  //$ Credit
  int? accountsIdForCapital =
      StoreAccounts.getAccountByCode('211000')?.accountsId;
  var capitalPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAmount: cashAmount,
    transactionLineAccountId: accountsIdForCapital,
    transactionLineDescription: transactionsDescription,
  );

  lines.addAll([cashPart, capitalPart]);

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionsCurrencyId: cashModel.cashAmountCurrencyId,
        transactionsDescription: transactionsDescription,
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
