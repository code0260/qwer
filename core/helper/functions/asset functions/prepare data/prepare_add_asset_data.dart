import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/core/helper/functions/asset%20functions/prepare%20data/get_asset_code.dart';
import 'package:almonazim/data/data%20source/locale/store_accounts.dart';
import 'package:almonazim/data/model/asset%20models/asset_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/add_transaction_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_line_input_model.dart';
import 'package:almonazim/data/model/transaction%20models/transaction_model.dart';

Map<String, dynamic> prepareAddAssetData(AssetInputModel addAssetModel) {
  Map<String, dynamic> data = {};
  data["asset"] = addAssetModel.toMap();

  String code = "";
  code = getAssetCode(addAssetModel.assetsCategory!);
  int accountsIdForAsset = StoreAccounts.getAccountByCode(code)!.accountsId!;
  int accountsIdForCash = StoreAccounts.getAccountByCode("121000")!.accountsId!;

  var transactionsDescription = "شراء ${addAssetModel.assetsName}";
  double amount = addAssetModel.assetsCostInBase ?? addAssetModel.assetsCost!;

  var assetPart = TransactionLineInputModel(
      transactionLineDebitCredit: "Debit",
      transactionLineAmount: amount,
      transactionLineAccountId: accountsIdForAsset,
      transactionLineDescription: transactionsDescription,
      transactionLinePartnerType: TransactionPartnerType.asset.name);
  var cashPart = TransactionLineInputModel(
    transactionLineDebitCredit: "Credit",
    transactionLineAmount: amount,
    transactionLineAccountId: accountsIdForCash,
    transactionLineDescription: transactionsDescription,
  );

  var addTransactionModel = AddTransactionModel(
      transactionModel: TransactionModel(
        transactionsDescription: transactionsDescription,
        transactionsCurrencyId: addAssetModel.assetsCurrencyId,
        transactionsTransactionDate: addAssetModel.assetsPurchaseDate,
      ),
      lines: [assetPart, cashPart]);
  data["transaction_data"] = addTransactionModel.toMap();
  return data;
}
