import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/debt%20models/debt_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareDebitDebt(DebtInputModel debtInputModel) {
  Map data = {};
  data["debt"] = debtInputModel.toMap();
  // transaction
  List<TransactionLineInputModel> lines = [];
  String transactionsDescription = "استدانة مبلغ مالي من  ";
  if (debtInputModel.debtsClientsId != null) {
    transactionsDescription +=
        debtInputModel.clientsType == ClientType.customer.name
            ? "الزبون "
            : "المورد ";
    transactionsDescription += debtInputModel.clientsName ?? "";
  } else {
    transactionsDescription += "${debtInputModel.debtsPersonName}";
  }
  //$ amount
  int nearFactorBase = currencies
      .firstWhere((element) => element.businessCurrencyIsBase == 1)
      .businessCurrencyNearFactor!;
  double amount = (debtInputModel.debtsTotalAmountInBase ??
          debtInputModel.debtsTotalAmount!) -
      (debtInputModel.debtsPaidAmountInBase ?? debtInputModel.debtsPaidAmount!)
          .roundToNearest(nearFactorBase);

  //$ Debit
  int accountsIdForCashOrCapital = StoreAccounts.getAccountByCode(
          debtInputModel.addDebtFrom == AddDebtFrom.cash ? '121000' : '211000')!
      .accountsId!;
  var cashOrCapitalPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForCashOrCapital,
    transactionLineDescription: transactionsDescription,
  );
  lines.add(cashOrCapitalPart);

  if (debtInputModel.debtsClientsId == null) {
    int daysDifference = debtInputModel.debtsDueDate == null
        ? 10
        : DateTime.parse(debtInputModel.debtsDueDate!)
            .difference(DateTime.now())
            .inDays;
    if (daysDifference > 365) {
      // long-term loan
      //$ Credit
      int accountsIdForLongTermDebt =
          StoreAccounts.getAccountByCode('225000')!.accountsId!;
      var longTermDebtPart = TransactionLineInputModel(
        transactionLineDebitCredit: "Credit",
        transactionLineAmount: amount,
        transactionLineAccountId: accountsIdForLongTermDebt,
        transactionLineDescription: transactionsDescription,
      );
      lines.add(longTermDebtPart);
    } else {
      // short-term loan
      //$ Credit
      int accountsIdForShortTermDebt =
          StoreAccounts.getAccountByCode('232000')!.accountsId!;
      var shortTermDebtPart = TransactionLineInputModel(
        transactionLineDebitCredit: "Credit",
        transactionLineAmount: amount,
        transactionLineAccountId: accountsIdForShortTermDebt,
        transactionLineDescription: transactionsDescription,
      );
      lines.add(shortTermDebtPart);
    }
  } else {
    int clientAccountId;
    if (debtInputModel.clientsType == ClientType.importer.name) {
      clientAccountId = StoreAccounts.getAccountByCode('231000')!.accountsId!;
    } else {
      clientAccountId = StoreAccounts.getAccountByCode('122000')!.accountsId!;
    }
    var accountsPayablePart = TransactionLineInputModel(
        transactionLineDebitCredit: "Credit",
        transactionLineAmount: amount,
        transactionLineAccountId: clientAccountId,
        transactionLineDescription: transactionsDescription,
        transactionLinePartnerType: TransactionLinePartnerType.client.name,
        transactionLinePartnerId: debtInputModel.debtsClientsId!);
    lines.add(accountsPayablePart);
  }

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionReferenceNumberType:
            TransactionReferenceNumberType.debt.name,
        transactionsDescription: transactionsDescription,
        transactionsCurrencyId: debtInputModel.debtsAmountCurrencyId,
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
