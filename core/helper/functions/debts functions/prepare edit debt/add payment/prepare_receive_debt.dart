import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/formatters/formatter.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/prepare_transaction_line_for_exchange.dart';
import 'package:almonazim/core/helper/functions/debts%20functions/prepare%20edit%20debt/prepare_exchange_rate_in_receive.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/debt%20models/debt_model.dart';
import 'package:almonazim/data/model/debt%20models/debt_payment_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareReceiveDebt(
    DebtPaymentInputModel debtPaymentInputModel, DebtModel debtModel) {
  Map data = {};
  data["debt_payment"] = debtPaymentInputModel.toMap();
  double amount = debtPaymentInputModel.debtPaymentsAmountInBase ??
      debtPaymentInputModel.debtPaymentsAmount!;

  // transaction
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription =
      "استلام مبلغ ${Formatter.formatAmount(debtPaymentInputModel.debtPaymentsAmount!, currencyId: debtPaymentInputModel.debtPaymentsAmountCurrencyId)} من  ${debtPaymentInputModel.clientsName ?? debtPaymentInputModel.personName}";
  //$ exchange
  double exchangeAmount =
      prepareExchangeRateInReceive(debtPaymentInputModel, debtModel);
  TransactionLineInputModel? exchangeLine = prepareTransactionLineForExchange(
      exchangeAmount, transactionsDescription, data);
  if (exchangeLine != null) {
    lines.add(exchangeLine);
  }
  //$ Debit
  int accountsIdForCash = StoreAccounts.getAccountByCode('121000')!.accountsId!;
  var cashPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForCash,
    transactionLineDescription: transactionsDescription,
  );
  lines.addAll([cashPart]);
  //$ Credit
  if (debtModel.debtsEmployeesId != null) {
    int accountsIdForEmployeeDebt =
        StoreAccounts.getAccountByCode('125001')!.accountsId!;
    var employeeDebtPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: amount - exchangeAmount,
      transactionLineAccountId: accountsIdForEmployeeDebt,
      transactionLinePartnerType: TransactionPartnerType.employee.name,
      transactionLinePartnerId: debtModel.debtsEmployeesId,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(employeeDebtPart);
  } else if (debtModel.debtsClientsId != null) {
    int clientAccountId;
    if (debtPaymentInputModel.clientsType == ClientType.importer.name) {
      clientAccountId = StoreAccounts.getAccountByCode('231000')!.accountsId!;
    } else {
      clientAccountId = StoreAccounts.getAccountByCode('122000')!.accountsId!;
    }
    //$ debit
    var accountsReceivablePart = TransactionLineInputModel(
        transactionLineDebitCredit: "Credit",
        transactionLineAmount: amount - exchangeAmount,
        transactionLineAccountId: clientAccountId,
        transactionLineDescription: transactionsDescription,
        transactionLinePartnerType: TransactionLinePartnerType.client.name,
        transactionLinePartnerId: debtModel.debtsClientsId!);
    lines.add(accountsReceivablePart);
  } else {
    int accountsIdForOtherDebt =
        StoreAccounts.getAccountByCode('125004')!.accountsId!;
    var otherDebtPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: amount - exchangeAmount,
      transactionLineAccountId: accountsIdForOtherDebt,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(otherDebtPart);
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
