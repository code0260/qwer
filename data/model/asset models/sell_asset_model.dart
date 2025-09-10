// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/data/model/asset%20models/asset_model.dart';

class SellAssetModel {
  AssetModel? assetModel;
  double? amount;
  double? amountInBase;
  int? currencyId;
  SellAssetModel({
    this.assetModel,
    this.amount,
    this.amountInBase,
    this.currencyId,
  });
}
