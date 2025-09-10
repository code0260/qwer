import 'dart:math';

import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/extension/double_extension.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount_to_base.dart';
import 'package:almonazim/core/helper/functions/partner%20functions/get_partner_id_by_name.dart';
import 'package:almonazim/core/helper/functions/tax%20functions/calculate_total_sell_tax.dart';
import 'package:almonazim/core/helper/functions/unit%20functions/get_count_unit_conversion.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/invoice%20models/invoice_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

AddTransactionModel prepareSellTransaction(InvoiceModel invoiceModel) {
  List<TransactionLineInputModel> lines = [];
  var transactionsDescription =
      "بيع بضاعة ل ${invoiceModel.clientsName ?? invoiceModel.partnersName ?? "زبون عام"} فاتورة رقم ${invoiceModel.invoicesNumber}";
  //$ amounts
  int nearFactorBase = currencies
      .firstWhere((element) => element.businessCurrencyIsBase == 1)
      .businessCurrencyNearFactor!;

  double shippingCost = (invoiceModel.invoicesShippingCostInBase ??
          invoiceModel.invoicesShippingCost ??
          0)
      .roundToNearest(nearFactorBase);
  double invoiceAmount = (invoiceModel.invoicesAmountInBase ??
          invoiceModel.invoicesDiscountedAmount!)
      .roundToNearest(nearFactorBase);
  double? debtPaidAmount =
      (invoiceModel.debtsPaidAmountInBase ?? invoiceModel.debtsPaidAmount)
          ?.roundToNearest(nearFactorBase);
  double cost = (invoiceAmount + shippingCost);
  double cogsValue = cogs.roundToNearest(nearFactorBase);
  double vatTaxAmount = calculateTotalSellTax(allowedTaxTypes: [TaxType.vat])
      .roundToNearest(nearFactorBase);
  double undiscountedAmount = convertAmountToBase(
      invoiceModel.invoicesUndiscountedAmount!,
      invoiceModel.invoicesAmountCurrencyId!);

  //$ accounts
  int accountsIdForInventory =
      StoreAccounts.getAccountByCode('123000')!.accountsId!;
  int accountsIdForCOGS = StoreAccounts.getAccountByCode('311000')!.accountsId!;
  int accountsIdForSalesRevenue =
      StoreAccounts.getAccountByCode('411')!.accountsId!;
  int accountsIdForShippingRevenue =
      StoreAccounts.getAccountByCode('413')!.accountsId!;
  int accountsIdForDiscountExpense =
      StoreAccounts.getAccountByCode('332003')!.accountsId!;

  if (vatTaxAmount != 0) {
    //$ Debit
    int accountsIdForOutputVat =
        StoreAccounts.getAccountByCode('233004')!.accountsId!;
    var outputVatPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: vatTaxAmount,
      transactionLineAccountId: accountsIdForOutputVat,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(outputVatPart);
  }
  //$ credit
  var salesRevenuePart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAmount: (undiscountedAmount - vatTaxAmount),
    transactionLineAccountId: accountsIdForSalesRevenue,
    transactionLineDescription: transactionsDescription,
  );
  if (cogsValue != 0) {
    var inventoryPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: cogsValue,
      transactionLineAccountId: accountsIdForInventory,
      transactionLineDescription: transactionsDescription,
    );
    //$ debit
    var cogsPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: cogsValue,
      transactionLineAccountId: accountsIdForCOGS,
      transactionLineDescription: transactionsDescription,
    );
    lines.addAll([inventoryPart, cogsPart]);
  }
  if (shippingCost != 0) {
    var shippingRevenuePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: shippingCost,
      transactionLineAccountId: accountsIdForShippingRevenue,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(shippingRevenuePart);
  }

  lines.addAll([salesRevenuePart]);
  //$ discount
  if (invoiceModel.invoicesDiscountValue != 0 &&
      invoiceModel.invoicesDiscountValue != null) {
    var discountPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: (undiscountedAmount - cost),
      transactionLineAccountId: accountsIdForDiscountExpense,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(discountPart);
  }

  if (invoiceModel.invoicesPaymentStatus == "paid") {
    if (invoiceModel.invoicesPartnerId != null) {
      int accountsIdForPartner =
          getPartnerIdByName(invoiceModel.partnersName!, '1260');
      //$ debit
      var partnerPart = TransactionLineInputModel(
        transactionLineDebitCredit: "Debit",
        transactionLineAmount: cost,
        transactionLineAccountId: accountsIdForPartner,
        transactionLinePartnerId: invoiceModel.invoicesPartnerId,
        transactionLinePartnerType: TransactionLinePartnerType.partner.name,
        transactionLineDescription: transactionsDescription,
      );
      lines.add(partnerPart);
    } else {
      //$ debit
      int accountsIdForCash =
          StoreAccounts.getAccountByCode('121000')!.accountsId!;
      var cashPart = TransactionLineInputModel(
        transactionLineDebitCredit: "Debit",
        transactionLineAmount: cost,
        transactionLineAccountId: accountsIdForCash,
        transactionLineDescription: transactionsDescription,
      );
      lines.add(cashPart);
    }
  } else if (invoiceModel.invoicesPaymentStatus == "unpaid") {
    int accountsIdForAccountsReceivable =
        StoreAccounts.getAccountByCode('122000')!.accountsId!;
    //$ debit
    var accountsReceivablePart = TransactionLineInputModel(
        transactionLineDebitCredit: "Debit",
        transactionLineAmount: cost,
        transactionLineAccountId: accountsIdForAccountsReceivable,
        transactionLineDescription: transactionsDescription,
        transactionLinePartnerType: "client",
        transactionLinePartnerId: invoiceModel.invoicesClientId!);
    lines.add(accountsReceivablePart);
  } else {
    int accountsIdForCash =
        StoreAccounts.getAccountByCode('121000')!.accountsId!;
    int accountsIdForAccountsReceivable =
        StoreAccounts.getAccountByCode('122000')!.accountsId!;
    //$ debit
    var cashPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: debtPaidAmount,
      transactionLineAccountId: accountsIdForCash,
      transactionLineDescription: transactionsDescription,
    );
    var accountsReceivablePart = TransactionLineInputModel(
        transactionLineDebitCredit: "Debit",
        transactionLineAmount: (cost - debtPaidAmount!),
        transactionLineAccountId: accountsIdForAccountsReceivable,
        transactionLineDescription: transactionsDescription,
        transactionLinePartnerType: TransactionLinePartnerType.client.name,
        transactionLinePartnerId: invoiceModel.invoicesClientId!);
    lines.addAll([cashPart, accountsReceivablePart]);
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
        transactionsDescription: transactionsDescription,
        transactionsCurrencyId: transactionsCurrencyId,
        transactionsTransactionDate: invoiceModel.invoicesCreatedAt,
      ),
      lines: lines);
}

double get cogs {
  double cogs = 0;
  for (final sellItemModel in cartSellHome) {
    double remainingBatchQuantity = sellItemModel.productCount;
    for (int i = 0; i < sellItemModel.chosenPlaceModels.length; i++) {
      double itemConversion =
          (sellItemModel.getProductModel.productModel.unitsBaseConversion! *
                  (sellItemModel.productConversion ?? 1))
              .roundToDouble(); //! be careful about this.
      if (remainingBatchQuantity > 0) {
        //$ batch
        double batchesOriginalRemaining = sellItemModel.chosenPlaceModels[i]
                .batchModel.batchesProductsRemainingCount ??
            sellItemModel
                .chosenPlaceModels[i].productPlaceModel.productPlacesCount ??
            1;
        double batchConversion = sellItemModel
                .chosenPlaceModels[i].batchModel.unitsConversionFactor
                ?.toDouble() ??
            (sellItemModel.chosenPlaceModels[i].productPlaceModel
                        .productPlacesCountUnitId ==
                    null
                ? 1
                : getCountUnitConversion(sellItemModel.chosenPlaceModels[i]
                    .productPlaceModel.productPlacesCountUnitId!));
        double availableBatchQuantity =
            batchesOriginalRemaining * (batchConversion / itemConversion);
        double usedBatchQuantity =
            min(availableBatchQuantity, remainingBatchQuantity);
        double decrementBatchQuantity =
            usedBatchQuantity * (batchConversion / itemConversion);

        if (sellItemModel.getProductModel.productModel.productsType ==
                ProductType.product.name &&
            sellItemModel
                    .chosenPlaceModels[i].batchModel.batchesProductUnitCost !=
                null) {
          double unitCost = convertAmountToBase(
              sellItemModel
                  .chosenPlaceModels[i].batchModel.batchesProductUnitCost!,
              sellItemModel
                  .chosenPlaceModels[i].batchModel.batchesProductsCurrencyId!);
          cogs += (unitCost) *
              decrementBatchQuantity *
              (batchConversion /
                  sellItemModel
                      .getProductModel.productModel.unitsBaseConversion!);
          remainingBatchQuantity -= usedBatchQuantity;
        }
      }
    }
  }
  return cogs;
}
