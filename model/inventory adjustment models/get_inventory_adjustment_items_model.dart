import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_item_model.dart';
import 'package:almonazim/data/model/inventory%20adjustment%20models/inventory_adjustment_model.dart';

class GetInventoryAdjustmentItemModel {
  final InventoryAdjustmentModel inventoryAdjustmentModel;
  final List<InventoryAdjustmentItemModel> items;

  GetInventoryAdjustmentItemModel(
      {required this.inventoryAdjustmentModel, required this.items});

  factory GetInventoryAdjustmentItemModel.fromJson(Map<String, dynamic> json) {
    return GetInventoryAdjustmentItemModel(
      inventoryAdjustmentModel:
          InventoryAdjustmentModel.fromJson(json["inventory_adjustment"]),
      items: List.generate(
          json["inventory_adjustment_items"].length,
          (index) => InventoryAdjustmentItemModel.fromJson(
              json["inventory_adjustment_items"][index])),
    );
  }
}
