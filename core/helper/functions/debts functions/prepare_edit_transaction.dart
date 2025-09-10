import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/debt%20models/edit_debt_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';

void prepareEditTransaction(
    EditDebtModel editDebtModel,
    double amount,
    String transactionsDescription,
    List<TransactionLineInputModel> lines,
    String creditDebit,
    int accountsIdForOther) {
  if (editDebtModel.debtsEmployeesId != null) {
    // Employee
    int accountsIdForEmployeeDebt =
        StoreAccounts.getAccountByCode("125001")!.accountsId!;
    var employeeDebtPart = TransactionLineInputModel(
      transactionLineDebitCredit: creditDebit,
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForEmployeeDebt,
      transactionLineDescription: transactionsDescription,
      transactionLinePartnerType: TransactionPartnerType.employee.name,
      transactionLinePartnerId: editDebtModel.debtsEmployeesId,
    );
    lines.add(employeeDebtPart);
  } else if (editDebtModel.clientsId != null) {
    // Client (importer or customer)
    int accountId;
    if (editDebtModel.clientsType == ClientType.importer.name) {
      accountId = StoreAccounts.getAccountByCode('231000')!.accountsId!;
    } else {
      accountId = StoreAccounts.getAccountByCode('122000')!.accountsId!;
    }
    var clientDebtPart = TransactionLineInputModel(
      transactionLineDebitCredit: creditDebit,
      transactionLineAmount: amount,
      transactionLineAccountId: accountId,
      transactionLineDescription: transactionsDescription,
      transactionLinePartnerType: TransactionPartnerType.client.name,
      transactionLinePartnerId: editDebtModel.clientsId,
    );
    lines.add(clientDebtPart);
  } else {
    // Other (manual/anonymous debt)
    var otherDebtPart = TransactionLineInputModel(
      transactionLineDebitCredit: creditDebit,
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForOther,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(otherDebtPart);
  }
}
