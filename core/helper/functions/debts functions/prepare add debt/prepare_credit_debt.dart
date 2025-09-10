import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/debt%20models/debt_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map prepareCreditDebt(DebtInputModel debtInputModel) {
  Map data = {};
  data["debt"] = debtInputModel.toMap();
  // transaction
  List<TransactionLineInputModel> lines = [];
  String transactionsDescription = "إنشاء دين ل";
  if (debtInputModel.debtsEmployeesId != null) {
    transactionsDescription += "لموظف";
  } else if (debtInputModel.debtsClientsId != null) {
    transactionsDescription +=
        debtInputModel.clientsType == ClientType.customer.name
            ? "الزبون "
            : "المورد ";
    transactionsDescription += debtInputModel.clientsName ?? "";
  } else {
    transactionsDescription += "لطرف آخر: ${debtInputModel.debtsPersonName}";
  }
  //$ amount
  int nearFactorBase = currencies
      .firstWhere((element) => element.businessCurrencyIsBase == 1)
      .businessCurrencyNearFactor!;
  double amount = (debtInputModel.debtsTotalAmountInBase ??
          debtInputModel.debtsTotalAmount!) -
      (debtInputModel.debtsPaidAmountInBase ?? debtInputModel.debtsPaidAmount!)
          .roundToNearest(nearFactorBase);
  //$ Credit
  int accountsIdForCashOrCapital = StoreAccounts.getAccountByCode(
          debtInputModel.addDebtFrom == AddDebtFrom.cash ? '121000' : '211000')!
      .accountsId!;
  var cashOrCapitalPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForCashOrCapital,
    transactionLineDescription: transactionsDescription,
  );
  lines.add(cashOrCapitalPart);

  //$ Debit
  if (debtInputModel.debtsEmployeesId != null) {
    int accountsIdForEmployeeDebt =
        StoreAccounts.getAccountByCode('125001')!.accountsId!;
    var employeeDebtPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForEmployeeDebt,
      transactionLinePartnerType: TransactionPartnerType.employee.name,
      transactionLinePartnerId: debtInputModel.debtsEmployeesId,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(employeeDebtPart);
  } else if (debtInputModel.debtsClientsId != null) {
    int clientAccountId;
    if (debtInputModel.clientsType == ClientType.importer.name) {
      clientAccountId = StoreAccounts.getAccountByCode('231000')!.accountsId!;
    } else {
      clientAccountId = StoreAccounts.getAccountByCode('122000')!.accountsId!;
    }
    //$ debit
    var accountsReceivablePart = TransactionLineInputModel(
        transactionLineDebitCredit: "Debit",
        transactionLineAmount: amount,
        transactionLineAccountId: clientAccountId,
        transactionLineDescription: transactionsDescription,
        transactionLinePartnerType: TransactionLinePartnerType.client.name,
        transactionLinePartnerId: debtInputModel.debtsClientsId!);
    lines.add(accountsReceivablePart);
  } else {
    int accountsIdForOtherDebt =
        StoreAccounts.getAccountByCode('125004')!.accountsId!;
    var otherDebtPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForOtherDebt,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(otherDebtPart);
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
