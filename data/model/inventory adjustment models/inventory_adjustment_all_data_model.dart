// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_data_model.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_model.dart';

class InventoryAdjustmentAllDataModel {
  final List<InventoryAdjustmentDataModel> items;
  final InventoryAdjustmentModel inventoryAdjustmentModel;
  InventoryAdjustmentAllDataModel({
    required this.items,
    required this.inventoryAdjustmentModel,
  });

  InventoryAdjustmentAllDataModel copyWith({
    List<InventoryAdjustmentDataModel>? items,
    InventoryAdjustmentModel? inventoryAdjustmentModel,
  }) {
    return InventoryAdjustmentAllDataModel(
      items: items ?? this.items,
      inventoryAdjustmentModel:
          inventoryAdjustmentModel ?? this.inventoryAdjustmentModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': items.map((x) => x.toMap()).toList(),
      'inventoryAdjustmentModel': inventoryAdjustmentModel.toJson(),
    };
  }

  factory InventoryAdjustmentAllDataModel.fromMap(Map<String, dynamic> map) {
    return InventoryAdjustmentAllDataModel(
      items: List<InventoryAdjustmentDataModel>.from(
        (map['items'] as List<int>).map<InventoryAdjustmentDataModel>(
          (x) =>
              InventoryAdjustmentDataModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      inventoryAdjustmentModel: InventoryAdjustmentModel.fromJson(
          map['inventoryAdjustmentModel'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryAdjustmentAllDataModel.fromJson(String source) =>
      InventoryAdjustmentAllDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'InventoryAdjustmentAllDataModel(items: $items, inventoryAdjustmentModel: $inventoryAdjustmentModel)';

  @override
  bool operator ==(covariant InventoryAdjustmentAllDataModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.items, items) &&
        other.inventoryAdjustmentModel == inventoryAdjustmentModel;
  }

  @override
  int get hashCode => items.hashCode ^ inventoryAdjustmentModel.hashCode;
}
