import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/formatters/formatter.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/prepare_transaction_line_for_exchange.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20edit%20debt/prepare_exchange_rate_in_pay.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_payment_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map preparePayDebt(
    DebtPaymentInputModel debtPaymentInputModel, DebtModel debtModel) {
  Map data = {};
  data["debt_payment"] = debtPaymentInputModel.toMap();
  double amount = debtPaymentInputModel.debtPaymentsAmountInBase ??
      debtPaymentInputModel.debtPaymentsAmount!;
  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription =
      "تسديد مبلغ ${Formatter.formatAmount(debtPaymentInputModel.debtPaymentsAmount!, currencyId: debtPaymentInputModel.debtPaymentsAmountCurrencyId)} ل  ${debtPaymentInputModel.clientsName ?? debtPaymentInputModel.personName}";
  //$ exchange
  double exchangeAmount =
      prepareExchangeRateInPay(debtPaymentInputModel, debtModel);
  TransactionLineInputModel? exchangeLine = prepareTransactionLineForExchange(
      exchangeAmount, transactionsDescription, data);
  if (exchangeLine != null) {
    lines.add(exchangeLine);
  }
  //$ Credit
  int accountsIdForCash = StoreAccounts.getAccountByCode('121000')!.accountsId!;
  var cashPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForCash,
    transactionLineDescription: transactionsDescription,
  );
  lines.addAll([cashPart]);
  //$ Debit
  if (debtModel.debtsClientsId == null) {
    int daysDifference = debtModel.debtsDueDate == null
        ? 10
        : DateTime.parse(debtModel.debtsDueDate!)
            .difference(DateTime.now())
            .inDays;
    if (daysDifference > 365) {
      // long-term loan
      int accountsIdForLongTermDebt =
          StoreAccounts.getAccountByCode('225000')!.accountsId!;
      var longTermDebtPart = TransactionLineInputModel(
        transactionLineDebitCredit: "Debit",
        transactionLineAmount: amount + exchangeAmount,
        transactionLineAccountId: accountsIdForLongTermDebt,
        transactionLineDescription: transactionsDescription,
      );
      lines.add(longTermDebtPart);
    } else {
      // short-term loan
      int accountsIdForShortTermDebt =
          StoreAccounts.getAccountByCode('232000')!.accountsId!;
      var shortTermDebtPart = TransactionLineInputModel(
        transactionLineDebitCredit: "Debit",
        transactionLineAmount: amount + exchangeAmount,
        transactionLineAccountId: accountsIdForShortTermDebt,
        transactionLineDescription: transactionsDescription,
      );
      lines.add(shortTermDebtPart);
    }
  } else {
    int clientAccountId;
    if (debtPaymentInputModel.clientsType == ClientType.importer.name) {
      clientAccountId = StoreAccounts.getAccountByCode('231000')!.accountsId!;
    } else {
      clientAccountId = StoreAccounts.getAccountByCode('122000')!.accountsId!;
    }

    var accountsPayablePart = TransactionLineInputModel(
        transactionLineDebitCredit: "Debit",
        transactionLineAmount: amount + exchangeAmount,
        transactionLineAccountId: clientAccountId,
        transactionLineDescription: transactionsDescription,
        transactionLinePartnerType: TransactionLinePartnerType.client.name,
        transactionLinePartnerId: debtModel.debtsClientsId!);
    lines.add(accountsPayablePart);
  }
  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionReferenceNumberType:
            TransactionReferenceNumberType.debt.name,
        transactionsCurrencyId:
            debtPaymentInputModel.debtPaymentsAmountCurrencyId,
        transactionsDescription: transactionsDescription,
        transactionsReferenceNumber: debtPaymentInputModel.debtPaymentsDebtsId,
        transactionsTransactionDate: DateTime.now().toString(),
      ),
      lines: lines);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
