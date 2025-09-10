import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class InventoryAdjustmentItemInputModel extends Equatable {
  int? inventoryAdjustmentItemsId;
  int? inventoryAdjustmentItemsAdjustmentId;
  int? inventoryAdjustmentItemsProductId;
  double? inventoryAdjustmentItemsCount;
  int? inventoryAdjustmentItemsCountUnitId;
  String? inventoryAdjustmentItemsUnitCost;
  String? inventoryAdjustmentItemsTotalAmount;
  String? inventoryAdjustmentCreatedAt;

  InventoryAdjustmentItemInputModel({
    this.inventoryAdjustmentItemsId,
    this.inventoryAdjustmentItemsAdjustmentId,
    this.inventoryAdjustmentItemsProductId,
    this.inventoryAdjustmentItemsCount,
    this.inventoryAdjustmentItemsCountUnitId,
    this.inventoryAdjustmentItemsUnitCost,
    this.inventoryAdjustmentItemsTotalAmount,
    this.inventoryAdjustmentCreatedAt,
  });

  factory InventoryAdjustmentItemInputModel.fromJson(
      Map<String, dynamic> json) {
    return InventoryAdjustmentItemInputModel(
      inventoryAdjustmentItemsId: json['inventory_adjustment_items_id'] as int?,
      inventoryAdjustmentItemsAdjustmentId:
          json['inventory_adjustment_items_adjustment_id'] as int?,
      inventoryAdjustmentItemsProductId:
          json['inventory_adjustment_items_product_id'] as int?,
      inventoryAdjustmentItemsCount:
          receiveDouble(json['inventory_adjustment_items_count']),
      inventoryAdjustmentItemsCountUnitId:
          json['inventory_adjustment_items_count_unit_id'] as int?,
      inventoryAdjustmentItemsUnitCost:
          json['inventory_adjustment_items_unit_cost'] as String?,
      inventoryAdjustmentItemsTotalAmount:
          json['inventory_adjustment_items_total_amount'] as String?,
      inventoryAdjustmentCreatedAt:
          json['inventory_adjustment_created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'inventory_adjustment_items_id': inventoryAdjustmentItemsId,
        'inventory_adjustment_items_adjustment_id':
            inventoryAdjustmentItemsAdjustmentId,
        'inventory_adjustment_items_product_id':
            inventoryAdjustmentItemsProductId,
        'inventory_adjustment_items_count': inventoryAdjustmentItemsCount,
        'inventory_adjustment_items_count_unit_id':
            inventoryAdjustmentItemsCountUnitId,
        'inventory_adjustment_items_unit_cost':
            inventoryAdjustmentItemsUnitCost,
        'inventory_adjustment_items_total_amount':
            inventoryAdjustmentItemsTotalAmount,
        'inventory_adjustment_created_at': inventoryAdjustmentCreatedAt,
      };

  InventoryAdjustmentItemInputModel copyWith({
    int? inventoryAdjustmentItemsId,
    int? inventoryAdjustmentItemsAdjustmentId,
    int? inventoryAdjustmentItemsProductId,
    double? inventoryAdjustmentItemsCount,
    int? inventoryAdjustmentItemsCountUnitId,
    String? inventoryAdjustmentItemsUnitCost,
    String? inventoryAdjustmentItemsTotalAmount,
    String? inventoryAdjustmentCreatedAt,
  }) {
    return InventoryAdjustmentItemInputModel(
      inventoryAdjustmentItemsId:
          inventoryAdjustmentItemsId ?? this.inventoryAdjustmentItemsId,
      inventoryAdjustmentItemsAdjustmentId:
          inventoryAdjustmentItemsAdjustmentId ??
              this.inventoryAdjustmentItemsAdjustmentId,
      inventoryAdjustmentItemsProductId: inventoryAdjustmentItemsProductId ??
          this.inventoryAdjustmentItemsProductId,
      inventoryAdjustmentItemsCount:
          inventoryAdjustmentItemsCount ?? this.inventoryAdjustmentItemsCount,
      inventoryAdjustmentItemsCountUnitId:
          inventoryAdjustmentItemsCountUnitId ??
              this.inventoryAdjustmentItemsCountUnitId,
      inventoryAdjustmentItemsUnitCost: inventoryAdjustmentItemsUnitCost ??
          this.inventoryAdjustmentItemsUnitCost,
      inventoryAdjustmentItemsTotalAmount:
          inventoryAdjustmentItemsTotalAmount ??
              this.inventoryAdjustmentItemsTotalAmount,
      inventoryAdjustmentCreatedAt:
          inventoryAdjustmentCreatedAt ?? this.inventoryAdjustmentCreatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      inventoryAdjustmentItemsId,
      inventoryAdjustmentItemsAdjustmentId,
      inventoryAdjustmentItemsProductId,
      inventoryAdjustmentItemsCount,
      inventoryAdjustmentItemsCountUnitId,
      inventoryAdjustmentItemsUnitCost,
      inventoryAdjustmentItemsTotalAmount,
      inventoryAdjustmentCreatedAt,
    ];
  }
}
