import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class InventoryAdjustmentItemModel extends Equatable {
  final int? inventoryAdjustmentItemsId;
  final int? inventoryAdjustmentItemsAdjustmentId;
  final int? inventoryAdjustmentItemsProductId;
  final double? inventoryAdjustmentItemsCount;
  final int? inventoryAdjustmentItemsCountUnitId;
  final double? inventoryAdjustmentItemsUnitCost;
  final double? inventoryAdjustmentItemsTotalAmount;
  final String? inventoryAdjustmentCreatedAt;

  // New properties
  final String? productsName;
  final String? unitsName;
  final double? unitsConversionFactor;
  final String? unitsSymbol;

  const InventoryAdjustmentItemModel({
    this.inventoryAdjustmentItemsId,
    this.inventoryAdjustmentItemsAdjustmentId,
    this.inventoryAdjustmentItemsProductId,
    this.inventoryAdjustmentItemsCount,
    this.inventoryAdjustmentItemsCountUnitId,
    this.inventoryAdjustmentItemsUnitCost,
    this.inventoryAdjustmentItemsTotalAmount,
    this.inventoryAdjustmentCreatedAt,
    // New properties in constructor
    this.productsName,
    this.unitsName,
    this.unitsConversionFactor,
    this.unitsSymbol,
  });

  factory InventoryAdjustmentItemModel.fromJson(Map<String, dynamic> json) {
    return InventoryAdjustmentItemModel(
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
          receiveDouble(json['inventory_adjustment_items_unit_cost']),
      inventoryAdjustmentItemsTotalAmount:
          receiveDouble(json['inventory_adjustment_items_total_amount']),
      inventoryAdjustmentCreatedAt:
          json['inventory_adjustment_created_at'] as String?,
      // New properties from JSON
      productsName: json['products_name'] as String?,
      unitsName: json['units_name'] as String?,
      unitsConversionFactor: receiveDouble(json['units_conversion_factor'])
          ?.toDouble(), // Handle num to double conversion
      unitsSymbol: json['units_symbol'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'inventory_adjustment_items_id': inventoryAdjustmentItemsId,
      'inventory_adjustment_items_adjustment_id':
          inventoryAdjustmentItemsAdjustmentId,
      'inventory_adjustment_items_product_id':
          inventoryAdjustmentItemsProductId,
      'inventory_adjustment_items_count': inventoryAdjustmentItemsCount,
      'inventory_adjustment_items_count_unit_id':
          inventoryAdjustmentItemsCountUnitId,
      'inventory_adjustment_items_unit_cost': inventoryAdjustmentItemsUnitCost,
      'inventory_adjustment_items_total_amount':
          inventoryAdjustmentItemsTotalAmount,
      'inventory_adjustment_created_at': inventoryAdjustmentCreatedAt,
      // New properties to JSON
      'products_name': productsName,
      'units_name': unitsName,
      'units_conversion_factor': unitsConversionFactor,
      'units_symbol': unitsSymbol,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  InventoryAdjustmentItemModel copyWith({
    int? inventoryAdjustmentItemsId,
    int? inventoryAdjustmentItemsAdjustmentId,
    int? inventoryAdjustmentItemsProductId,
    double? inventoryAdjustmentItemsCount,
    int? inventoryAdjustmentItemsCountUnitId,
    double? inventoryAdjustmentItemsUnitCost,
    double? inventoryAdjustmentItemsTotalAmount,
    String? inventoryAdjustmentCreatedAt,
    // New properties for copyWith
    String? productsName,
    String? unitsName,
    double? unitsConversionFactor,
    String? unitsSymbol,
  }) {
    return InventoryAdjustmentItemModel(
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
      // Assign new properties in copyWith
      productsName: productsName ?? this.productsName,
      unitsName: unitsName ?? this.unitsName,
      unitsConversionFactor:
          unitsConversionFactor ?? this.unitsConversionFactor,
      unitsSymbol: unitsSymbol ?? this.unitsSymbol,
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
      // Add new properties to props
      productsName,
      unitsName,
      unitsConversionFactor,
      unitsSymbol,
    ];
  }
}
