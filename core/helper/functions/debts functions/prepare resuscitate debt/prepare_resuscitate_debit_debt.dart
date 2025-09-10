import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare_edit_transaction.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareResuscitateDebitDebt(EditDebtModel editDebtModel) {
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

  //$ Credit: Accumulated Doubtful Debt
  int accountsIdForAccumulatedDoubtfulDebt =
      StoreAccounts.getAccountByCode('224000')!.accountsId!;
  var debitPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForAccumulatedDoubtfulDebt,
    transactionLineDescription: transactionsDescription,
  );
  lines.add(debitPart);
  //$ Credit: Based on source
  prepareEditTransaction(editDebtModel, amount, transactionsDescription, lines,
      'Debit', StoreAccounts.getAccountByCode("125004")!.accountsId!);

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
