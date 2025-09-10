import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

AddTransactionModel? prepareBuyShippingTransaction(InvoiceModel invoiceModel) {
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription =
      "شحن بضاعة من ${invoiceModel.clientsName} فاتورة رقم ${invoiceModel.invoicesNumber}";
  //$ amounts
  int nearFactorBase = currencies
      .firstWhere((element) => element.businessCurrencyIsBase == 1)
      .businessCurrencyNearFactor!;

  double shippingCost = (invoiceModel.invoicesShippingCostInBase ??
          invoiceModel.invoicesShippingCost ??
          0)
      .roundToNearest(nearFactorBase);
  if (shippingCost == 0) {
    return null;
  }
  //$ debit
  int accountsIdForInventory =
      StoreAccounts.getAccountByCode('123000')!.accountsId!;
  var inventoryPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: (shippingCost),
    transactionLineAccountId: accountsIdForInventory,
    transactionLineDescription: transactionsDescription,
  );
  lines.add(inventoryPart);

  if (invoiceModel.invoicesShippingPayment == "paid") {
    //$ credit
    int accountsIdForCash =
        StoreAccounts.getAccountByCode('121000')!.accountsId!;
    var cashPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: shippingCost,
      transactionLineAccountId: accountsIdForCash,
      transactionLineDescription: transactionsDescription,
    );
    lines.addAll([cashPart]);
  } else if (invoiceModel.invoicesShippingPayment == "unpaid") {
    //$ credit
    int accountsIdForAccountsPayable =
        StoreAccounts.getAccountByCode('231000')!.accountsId!;
    var accountsPayablePart = TransactionLineInputModel(
        transactionLineDebitCredit: "Credit",
        transactionLineAmount: shippingCost,
        transactionLineAccountId: accountsIdForAccountsPayable,
        transactionLineDescription: transactionsDescription,
        transactionLinePartnerType: TransactionLinePartnerType.client.name,
        transactionLinePartnerId: invoiceModel.invoicesShippingClientId!);
    lines.addAll([accountsPayablePart]);
  }

  return AddTransactionModel(
      transactionModel: TransactionModel(
        transactionReferenceNumberType:
            TransactionReferenceNumberType.invoice.name,
        transactionsCurrencyId: invoiceModel.invoicesShippingCurrencyId,
        transactionsDescription: transactionsDescription,
        transactionsTransactionDate: invoiceModel.invoicesCreatedAt,
      ),
      lines: lines);
}
