// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/data/model/price%20models/price_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:flutter/foundation.dart';

class GetProductModel {
  final ProductModel productModel;
  final List<PriceModel> prices;
  PriceModel chosenPriceModel;
  GetProductModel({
    required this.productModel,
    required this.prices,
    required this.chosenPriceModel,
  });

  GetProductModel copyWith({
    ProductModel? productModel,
    List<PriceModel>? prices,
    PriceModel? chosenPriceModel,
  }) {
    return GetProductModel(
      productModel: productModel ?? this.productModel,
      prices: prices ?? this.prices,
      chosenPriceModel: chosenPriceModel ?? this.chosenPriceModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': productModel.toMap(),
      'prices': prices.map((x) => x.toJson()).toList(),
      'chosen_price_model': chosenPriceModel.toJson(),
    };
  }

  factory GetProductModel.fromJson(Map<String, dynamic> map) {
    return GetProductModel(
      productModel:
          ProductModel.fromJson(map['product'] as Map<String, dynamic>),
      prices: List<PriceModel>.from(
        (map['prices'] as List<dynamic>).map<PriceModel>(
          (x) => PriceModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      chosenPriceModel: map['chosen_price_model'] == null
          ? PriceModel.fromJson(map['prices'][0])
          : PriceModel.fromJson(
              map['chosen_price_model'] as Map<String, dynamic>),
    );
  }
  @override
  String toString() =>
      'GetProductModel(productModel: $productModel, prices: $prices, chosenPriceModel: $chosenPriceModel)';

  @override
  bool operator ==(covariant GetProductModel other) {
    if (identical(this, other)) return true;

    return other.productModel == productModel &&
        listEquals(other.prices, prices) &&
        other.chosenPriceModel == chosenPriceModel;
  }

  @override
  int get hashCode =>
      productModel.hashCode ^ prices.hashCode ^ chosenPriceModel.hashCode;
}
