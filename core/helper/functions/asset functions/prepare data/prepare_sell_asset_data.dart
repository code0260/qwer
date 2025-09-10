import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/asset%20functions/prepare%20data/get_asset_code.dart';
import 'package:almonazim/core/helper/functions/asset%20functions/prepare%20data/get_depreciation_code.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/convert_amount.dart';
import 'package:almonazim/core/helper/functions/currency%20functions/prepare_transaction_line_for_exchange.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/asset%20models/asset_input_model.dart';
import 'package:almonazim/data/model/asset%20models/sell_asset_model.dart';
import 'package:almonazim/data/model/expenses%20models/expenses_input_model.dart';
import 'package:almonazim/data/model/revenues%20models/revenues_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map<String, dynamic> prepareSellAssetData(SellAssetModel sellAssetModel) {
  Map<String, dynamic> data = {};
  data['asset'] = AssetInputModel(
          assetsId: sellAssetModel.assetModel?.assetsId,
          assetsStatus: AssetStatus.sold.name)
      .toMap();

  if (sellAssetModel.assetModel == null) {
    throw ArgumentError("AssetModel cannot be null");
  }
  // base currency
  int baseCurrencyId = currencies
      .firstWhere((element) => element.businessCurrencyIsBase == 1)
      .businessCurrencyId!;
  // accounts
  String code = getAssetCode(sellAssetModel.assetModel!.assetsCategory!);
  String depreciationCode =
      getDepreciationCode(sellAssetModel.assetModel!.assetsCategory!);
  int cashAccountId = StoreAccounts.getAccountByCode("121000")!.accountsId!;
  int assetAccountId = StoreAccounts.getAccountByCode(code)!.accountsId!;
  int depreciationAccountId =
      StoreAccounts.getAccountByCode(depreciationCode)!.accountsId!;
  int revenueOnSellAssetAccountId =
      StoreAccounts.getAccountByCode("421000")!.accountsId!;
  int expenseOnSellAssetAccountId =
      StoreAccounts.getAccountByCode("341001")!.accountsId!;

  // prepareAmounts:
  double sellPrice = sellAssetModel.amountInBase ?? sellAssetModel.amount!;
  double accumulatedDepreciation = sellAssetModel
              .assetModel!.assetsCostInBase ==
          null
      ? (sellAssetModel.assetModel!.depreciationAccumulatedDepreciation ?? 0)
      : (sellAssetModel.assetModel!.assetsCostInBase! /
              sellAssetModel.assetModel!.assetsCost!) *
          (sellAssetModel.assetModel!.depreciationAccumulatedDepreciation ?? 0);
  // //$ exchange
  double exchangeAmount = 0;
  // double exchangeAmount = prepareExchangeRateAmount(
  //     sellAssetModel.assetModel!.assetsCost!,
  //     sellAssetModel.assetModel!.assetsCostInBase,
  //     sellAssetModel.assetModel!.assetsCost!,
  //     convertAmountToBase(sellAssetModel.assetModel!.assetsCost!,
  //         sellAssetModel.assetModel!.assetsCurrencyId!),
  //     sellAssetModel.assetModel!.assetsCurrencyId!,
  //     "expense",
  //     "prepaid");
  double assetCost = sellAssetModel.assetModel!.assetsCostInBase ??
      sellAssetModel.assetModel!.assetsCost!;
  double revenueOrExpenseAmount =
      ((sellPrice - assetCost) + accumulatedDepreciation) - exchangeAmount;

  String transactionsDescription =
      "بيع ${sellAssetModel.assetModel!.assetsName}";
  List<TransactionLineInputModel> lines = [];
  //$ exchange line
  TransactionLineInputModel? exchangeLine = prepareTransactionLineForExchange(
      exchangeAmount, transactionsDescription, data);
  if (exchangeLine != null) {
    lines.add(exchangeLine);
  }

  var assetPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: assetCost,
      transactionLineAccountId: assetAccountId,
      transactionLineDescription: transactionsDescription,
      transactionLinePartnerType: TransactionPartnerType.asset.name,
      transactionLinePartnerId: sellAssetModel.assetModel!.assetsId);

  if (accumulatedDepreciation > 0) {
    var depreciationPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: accumulatedDepreciation,
      transactionLineAccountId: depreciationAccountId,
      transactionLineDescription: transactionsDescription,
    );
    lines.add(depreciationPart);
  }

  var cashPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Debit",
    transactionLineAmount: sellPrice,
    transactionLineAccountId: cashAccountId,
    transactionLineDescription: transactionsDescription,
  );
  lines.addAll([cashPart, assetPart]);
  if (revenueOrExpenseAmount > 0) {
    var revenuePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Credit",
      transactionLineAmount: revenueOrExpenseAmount,
      transactionLineAccountId: revenueOnSellAssetAccountId,
      transactionLineDescription: transactionsDescription,
    );
    data['revenue'] = RevenueInputModel(
            revenuesName: 'إيراد $transactionsDescription',
            revenuesAmount: convertAmount(revenueOrExpenseAmount,
                baseCurrencyId, sellAssetModel.assetModel!.assetsCurrencyId!),
            revenuesAccountId: revenueOnSellAssetAccountId,
            revenuesAmountCurrencyId:
                sellAssetModel.assetModel!.assetsCurrencyId,
            revenuesAmountInBase:
                sellAssetModel.assetModel!.assetsCostInBase == null
                    ? null
                    : revenueOrExpenseAmount)
        .toMap();
    lines.add(revenuePart);
  } else if (revenueOrExpenseAmount < 0) {
    var expensePart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: revenueOrExpenseAmount.abs(),
      transactionLineAccountId: expenseOnSellAssetAccountId,
      transactionLineDescription: transactionsDescription,
    );

    data['expense'] = ExpenseInputModel(
            expensesName: 'مصروف $transactionsDescription',
            expensesAmount: convertAmount(revenueOrExpenseAmount.abs(),
                baseCurrencyId, sellAssetModel.assetModel!.assetsCurrencyId!),
            expensesAccountId: expenseOnSellAssetAccountId,
            expensesAmountCurrencyId:
                sellAssetModel.assetModel!.assetsCurrencyId,
            expensesAmountInBase:
                sellAssetModel.assetModel!.assetsCostInBase == null
                    ? null
                    : revenueOrExpenseAmount.abs())
        .toMap();
    lines.add(expensePart);
  }
  var addTransactionModel = AddTransactionModel(
    transactionModel: TransactionModel(
      transactionsDescription: transactionsDescription,
      transactionsCurrencyId: sellAssetModel.currencyId,
      transactionsTransactionDate: DateTime.now().toUtc().toString(),
    ),
    lines: lines,
  );
  // double difference = 0;
  // for (final line in lines) {
  //   if (line.transactionLineDebitCredit == "Debit") {
  //     difference += line.transactionLineAmount!;
  //   } else {
  //     difference -= line.transactionLineAmount!;
  //   }
  // }
  // print(difference);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
