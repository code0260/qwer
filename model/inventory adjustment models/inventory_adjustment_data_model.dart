// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_item_input_model.dart';
import 'package:almonazim/data/model/product%20models/product_model.dart';

class InventoryAdjustmentDataModel {
  final InventoryAdjustmentItemInputModel inventoryAdjustmentItemInputModel;
  final ProductModel productModel;
  double conversion;
  InventoryAdjustmentDataModel({
    this.conversion = 1,
    required this.inventoryAdjustmentItemInputModel,
    required this.productModel,
  });

  InventoryAdjustmentDataModel copyWith({
    InventoryAdjustmentItemInputModel? inventoryAdjustmentItemModel,
    ProductModel? productModel,
  }) {
    return InventoryAdjustmentDataModel(
      inventoryAdjustmentItemInputModel:
          inventoryAdjustmentItemModel ?? inventoryAdjustmentItemInputModel,
      productModel: productModel ?? this.productModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'inventoryAdjustmentItemModel':
          inventoryAdjustmentItemInputModel.toJson(),
      'productModel': productModel.toMap(),
      'conversion': conversion
    };
  }

  factory InventoryAdjustmentDataModel.fromMap(Map<String, dynamic> map) {
    return InventoryAdjustmentDataModel(
      inventoryAdjustmentItemInputModel:
          InventoryAdjustmentItemInputModel.fromJson(
              (map['inventoryAdjustmentItemModel']) as Map<String, dynamic>),
      productModel:
          ProductModel.fromJson(map['productModel'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryAdjustmentDataModel.fromJson(String source) =>
      InventoryAdjustmentDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'InventoryAdjustmentDataModel(inventoryAdjustmentItemModel: $inventoryAdjustmentItemInputModel, productModel: $productModel)';

  @override
  bool operator ==(covariant InventoryAdjustmentDataModel other) {
    if (identical(this, other)) return true;

    return other.inventoryAdjustmentItemInputModel ==
            inventoryAdjustmentItemInputModel &&
        other.productModel == productModel;
  }

  @override
  int get hashCode =>
      inventoryAdjustmentItemInputModel.hashCode ^ productModel.hashCode;
}
