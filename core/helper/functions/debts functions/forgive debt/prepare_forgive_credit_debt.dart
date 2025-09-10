import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare_edit_transaction.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareForgiveCreditDebt(EditDebtModel editDebtModel) {
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
  double amountInBase =
      convertAmountToBase(amount, editDebtModel.debtsAmountCurrencyId!);
  var revenueInputModel = RevenueInputModel(
      revenuesName:
          " مسامحة دين ${editDebtModel.clientsName ?? editDebtModel.debtsPersonName}",
      revenuesAmount: amount,
      revenuesAccountId: StoreAccounts.getAccountByCode('421005')!.accountsId!,
      revenuesAmountCurrencyId: editDebtModel.debtsAmountCurrencyId,
      revenuesType: RevenueType.done.name,
      revenuesDescription: "إيراد مسامحة دين رقم ${editDebtModel.debtsId}#",
      revenuesAmountInBase: amountInBase == amount ? null : amountInBase);
  data['revenue'] = revenueInputModel.toMap();
  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription = 'إيراد ${revenueInputModel.revenuesName}';
  // Debit: Based on type
  prepareEditTransaction(editDebtModel, amount, transactionsDescription, lines,
      'Debit', StoreAccounts.getAccountByCode("232000")!.accountsId!);

  //$ Credit
  var revenuePart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAmount: amount,
    transactionLineAccountId: revenueInputModel.revenuesAccountId,
    transactionLineDescription: transactionsDescription,
  );
  lines.add(revenuePart);

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
