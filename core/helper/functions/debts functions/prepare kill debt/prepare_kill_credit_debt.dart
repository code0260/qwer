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

Map prepareKillCreditDebt(EditDebtModel editDebtModel) {
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

  List<TransactionLineInputModel> lines = [];

  // Description
  String transactionsDescription = "إعدام دين ";
  if (editDebtModel.debtsEmployeesId != null) {
    transactionsDescription += "لموظف";
  } else if (editDebtModel.clientsId != null) {
    transactionsDescription +=
        editDebtModel.clientsType == ClientType.customer.name
            ? "الزبون "
            : "المورد ";
    transactionsDescription += editDebtModel.clientsName ?? "";
  } else {
    transactionsDescription += "لطرف آخر: ${editDebtModel.debtsPersonName}";
  }

  // Credit: Gain from debt write-off
  int accountsIdForGainFromDebt =
      StoreAccounts.getAccountByCode("421002")!.accountsId!;
  var gainFromDebtPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForGainFromDebt,
    transactionLineDescription: transactionsDescription,
  );
  lines.add(gainFromDebtPart);

  // Debit: Based on type
  prepareEditTransaction(editDebtModel, amount, transactionsDescription, lines,
      'Debit', StoreAccounts.getAccountByCode("232000")!.accountsId!);

  // Transaction model
  var addTransactionModel = AddTransactionModel(
    transactionModel: TransactionModel(
      transactionReferenceNumberType: TransactionReferenceNumberType.debt.name,
      transactionsDescription: transactionsDescription,
      transactionsCurrencyId: editDebtModel.debtsAmountCurrencyId,
      transactionsTransactionDate: DateTime.now().toString(),
    ),
    lines: lines,
  );

  data["transaction_data"] = addTransactionModel.toMap();

  // Revenue part
  double amountInBase =
      convertAmountToBase(amount, editDebtModel.debtsAmountCurrencyId!);
  data["revenue"] = RevenueInputModel(
          revenuesName: "إيراد إعدام دين",
          revenuesAmount: amount,
          revenuesAccountId: accountsIdForGainFromDebt,
          revenuesAmountCurrencyId: editDebtModel.debtsAmountCurrencyId,
          revenuesDescription: "إيراد إعدام دين رقم ${editDebtModel.debtsId}#",
          revenuesAmountInBase: amountInBase == amount ? null : amountInBase)
      .toMap();

  return data;
}
