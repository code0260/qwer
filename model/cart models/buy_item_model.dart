import 'package:almonazim/data/model/batch_model.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';
import 'package:almonazim/data/model/taxes models/product_tax_model.dart'; // Import ProductTaxModel
import 'package:flutter/foundation.dart';

class BuyItemModel {
  BatchModel batchModel;
  PlaceModel placeModel;
  ProductModel productModel;
  final List<ProductTaxModel> taxes; // Add taxes property

  BuyItemModel({
    required this.batchModel,
    required this.placeModel,
    required this.productModel,
    required this.taxes, // Add taxes to constructor
  });

  factory BuyItemModel.fromJson(Map<String, dynamic> json) => BuyItemModel(
        batchModel: BatchModel.fromJson(json['batchModel']),
        productModel: ProductModel.fromJson(json['productModel']),
        placeModel: PlaceModel.fromJson(json["placeModel"]),
        taxes: (json['taxes'] as List<dynamic>)
            .map((e) => ProductTaxModel.fromJson(e))
            .toList(), // Parse taxes from JSON
      );

  @override
  bool operator ==(covariant BuyItemModel other) {
    if (identical(this, other)) return true;

    return other.batchModel == batchModel &&
        other.productModel == productModel &&
        listEquals(taxes, other.taxes); // Compare taxes lists
  }

  Map toMap() {
    Map map = {
      "batchModel": batchModel.toServerMap(),
      "productModel": productModel.toMap(),
      "placeModel": placeModel.toMap(),
      "taxes": taxes
          .map((tax) => tax.toJson())
          .toList(), // Convert taxes to list of maps
    };
    return map;
  }

  @override
  int get hashCode =>
      batchModel.hashCode ^ productModel.hashCode ^ taxes.hashCode;
}
