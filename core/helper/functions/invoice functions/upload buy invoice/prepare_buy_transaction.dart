import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/core/helper/functions/tax%20functions/calculate_total_buy_tax.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

AddTransactionModel prepareBuyTransaction(InvoiceModel invoiceModel) {
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription =
      "شراء بضاعة من ${invoiceModel.clientsName} فاتورة رقم ${invoiceModel.invoicesNumber}";
  //$ amounts
  int nearFactorBase = currencies
      .firstWhere((element) => element.businessCurrencyIsBase == 1)
      .businessCurrencyNearFactor!;

  double invoiceAmount = (invoiceModel.invoicesAmountInBase ??
          invoiceModel.invoicesDiscountedAmount!)
      .roundToNearest(nearFactorBase);
  double? debtPaidAmount =
      (invoiceModel.debtsPaidAmountInBase ?? invoiceModel.debtsPaidAmount)
          ?.roundToNearest(nearFactorBase);
  double cost = (invoiceAmount);
  double vatTaxAmount = calculateTotalBuyTax(allowedTaxTypes: [TaxType.vat])
      .roundToNearest(nearFactorBase);
  double undiscountedAmount = convertAmountToBase(
      invoiceModel.invoicesUndiscountedAmount!,
      invoiceModel.invoicesAmountCurrencyId!);

  if (vatTaxAmount != 0) {
    //$ Debit
    int accountsIdForVat =
        StoreAccounts.getAccountByCode('125000')!.accountsId!;
    var vatPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: vatTaxAmount,
      transactionLineAccountId: accountsIdForVat,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(vatPart);
  }

  //$ debit
  int accountsIdForInventory =
      StoreAccounts.getAccountByCode('123000')!.accountsId!;
  var inventoryPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: (undiscountedAmount - vatTaxAmount),
    transactionLineAccountId: accountsIdForInventory,
    transactionLineDescription: transactionsDescription,
  );
  lines.add(inventoryPart);
  //$ discount
  if (invoiceModel.invoicesDiscountValue != 0 &&
      invoiceModel.invoicesDiscountValue != null) {
    int accountsIdForDiscount =
        StoreAccounts.getAccountByCode('417')!.accountsId!;
    var discountPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: (undiscountedAmount - cost),
      transactionLineAccountId: accountsIdForDiscount,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(discountPart);
  }

  if (invoiceModel.invoicesPaymentStatus == "paid") {
    //$ credit
    int accountsIdForCash =
        StoreAccounts.getAccountByCode('121000')!.accountsId!;
    var cashPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: cost,
      transactionLineAccountId: accountsIdForCash,
      transactionLineDescription: transactionsDescription,
    );
    lines.addAll([cashPart]);
  } else if (invoiceModel.invoicesPaymentStatus == "unpaid") {
    //$ credit
    int accountsIdForAccountsPayable =
        StoreAccounts.getAccountByCode('231000')!.accountsId!;
    var accountsPayablePart = TransactionLineInputModel(
        transactionLineDebitCredit: "Credit",
        transactionLineAmount: cost,
        transactionLineAccountId: accountsIdForAccountsPayable,
        transactionLineDescription: transactionsDescription,
        transactionLinePartnerType: TransactionLinePartnerType.client.name,
        transactionLinePartnerId: invoiceModel.invoicesClientId!);
    lines.addAll([accountsPayablePart]);
  } else {
    //$ credit
    int accountsIdForCash =
        StoreAccounts.getAccountByCode('121000')!.accountsId!;
    int accountsIdForAccountsPayable =
        StoreAccounts.getAccountByCode('231000')!.accountsId!;
    var cashPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: debtPaidAmount?.roundToNearest(nearFactorBase),
      transactionLineAccountId: accountsIdForCash,
      transactionLineDescription: transactionsDescription,
    );
    var accountsPayablePart = TransactionLineInputModel(
        transactionLineDebitCredit: "Credit",
        transactionLineAmount:
            (cost - debtPaidAmount!).roundToNearest(nearFactorBase),
        transactionLineAccountId: accountsIdForAccountsPayable,
        transactionLineDescription: transactionsDescription,
        transactionLinePartnerType: TransactionLinePartnerType.client.name,
        transactionLinePartnerId: invoiceModel.invoicesClientId!);
    lines.addAll([cashPart, accountsPayablePart]);
  }
  int transactionsCurrencyId = 0;
  if (invoiceModel.invoicesPaymentStatus == 'paid') {
    transactionsCurrencyId = invoiceModel.debtsPaidAmountCurrencyId ??
        invoiceModel.invoicesAmountCurrencyId!;
  } else if (invoiceModel.invoicesPaymentStatus == 'unpaid' ||
      invoiceModel.invoicesPaymentStatus == 'partial') {
    transactionsCurrencyId = invoiceModel.invoicesAmountCurrencyId!;
  }
  return AddTransactionModel(
      transactionModel: TransactionModel(
        transactionReferenceNumberType:
            TransactionReferenceNumberType.invoice.name,
        transactionsCurrencyId: transactionsCurrencyId,
        transactionsDescription: transactionsDescription,
        transactionsTransactionDate: invoiceModel.invoicesCreatedAt,
      ),
      lines: lines);
}
