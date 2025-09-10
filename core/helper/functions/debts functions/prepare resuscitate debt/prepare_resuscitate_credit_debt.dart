import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare_edit_transaction.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareResuscitateCreditDebt(EditDebtModel editDebtModel) {
  Map data = {};
  data["debt"] = editDebtModel.toMap();
  //$ amount
  int nearFactorBase = currencies
      .firstWhere((element) => element.businessCurrencyIsBase == 1)
      .businessCurrencyNearFactor!;
  double amount = (editDebtModel.debtsTotalAmountInBase ??
          editDebtModel.debtsTotalAmount!) -
      (editDebtModel.debtsPaidAmountInBase ?? editDebtModel.paidAmount!)
          .roundToNearest(nearFactorBase);

  // transaction
  List<TransactionLineInputModel> lines = [];
  // Determine description
  // Description
  String transactionsDescription = "إحياء دين ";
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

  // Debit: Gain from debt write-off
  int accountsIdForGainFromDebt =
      StoreAccounts.getAccountByCode("421002")!.accountsId!;
  var gainFromDebtPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForGainFromDebt,
    transactionLineDescription: transactionsDescription,
  );
  lines.add(gainFromDebtPart);

  // Credit: Based on type
  prepareEditTransaction(editDebtModel, amount, transactionsDescription, lines,
      'Credit', StoreAccounts.getAccountByCode("232000")!.accountsId!);

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionsDescription: transactionsDescription,
        transactionsCurrencyId: editDebtModel.debtsAmountCurrencyId,
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
