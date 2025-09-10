// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:almonazim/data/model/price%20models/prices_input_model.dart';
import 'package:almonazim/data/model/product%20models/product_input_model.dart';

class AddProductModel {
  ProductInputModel productInputModel;
  PriceInputModel buyPriceModel;
  PriceInputModel sellPriceModel;
  int? currencyId;
  AddProductModel(
      {required this.productInputModel,
      required this.buyPriceModel,
      required this.sellPriceModel,
      this.currencyId});

  AddProductModel copyWith(
      {ProductInputModel? productInputModel,
      PriceInputModel? buyPriceModel,
      PriceInputModel? sellPriceModel,
      int? currencyId}) {
    return AddProductModel(
        productInputModel: productInputModel ?? this.productInputModel,
        buyPriceModel: buyPriceModel ?? this.buyPriceModel,
        sellPriceModel: sellPriceModel ?? this.sellPriceModel,
        currencyId: currencyId ?? this.currencyId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': productInputModel.toMap(),
      'buyPrice': buyPriceModel.toMap(),
      'sellPrice': sellPriceModel.toMap(),
      'currencyId': currencyId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'AddProductModel(productInputModel: $productInputModel, buyPriceModel: $buyPriceModel, sellPriceModel: $sellPriceModel)';

  @override
  bool operator ==(covariant AddProductModel other) {
    if (identical(this, other)) return true;

    return other.productInputModel == productInputModel &&
        other.buyPriceModel == buyPriceModel &&
        other.sellPriceModel == sellPriceModel;
  }

  @override
  int get hashCode =>
      productInputModel.hashCode ^
      buyPriceModel.hashCode ^
      sellPriceModel.hashCode;
}
