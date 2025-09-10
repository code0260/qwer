import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class InventoryAdjustmentModel extends Equatable {
  final int? inventoryAdjustmentId;
  final int? inventoryAdjustmentBusinessId;
  final String? inventoryAdjustmentReason;
  final String? inventoryAdjustmentNumber;
  final double? inventoryAdjustmentAmount;
  final int? inventoryAdjustmentBuildingId;
  final String? inventoryAdjustmentCreatedAt;
  final String? buddingsName;

  const InventoryAdjustmentModel({
    this.inventoryAdjustmentId,
    this.inventoryAdjustmentBusinessId,
    this.inventoryAdjustmentReason,
    this.inventoryAdjustmentNumber,
    this.inventoryAdjustmentAmount,
    this.inventoryAdjustmentBuildingId,
    this.inventoryAdjustmentCreatedAt,
    this.buddingsName,
  });

  factory InventoryAdjustmentModel.fromJson(Map<String, dynamic> json) {
    return InventoryAdjustmentModel(
      inventoryAdjustmentId: json['inventory_adjustment_id'] as int?,
      inventoryAdjustmentBusinessId:
          json['inventory_adjustment_business_id'] as int?,
      inventoryAdjustmentReason: json['inventory_adjustment_reason'] as String?,
      inventoryAdjustmentNumber: json['inventory_adjustment_number'] as String?,
      inventoryAdjustmentAmount:
          receiveDouble(json['inventory_adjustment_amount']),
      inventoryAdjustmentBuildingId:
          json['inventory_adjustment_building_id'] as int?,
      inventoryAdjustmentCreatedAt:
          json['inventory_adjustment_created_at'] as String?,
      buddingsName: json['buildings_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'inventory_adjustment_id': inventoryAdjustmentId,
      'inventory_adjustment_business_id': inventoryAdjustmentBusinessId,
      'inventory_adjustment_reason': inventoryAdjustmentReason,
      'inventory_adjustment_number': inventoryAdjustmentNumber,
      'inventory_adjustment_amount': inventoryAdjustmentAmount,
      'inventory_adjustment_building_id': inventoryAdjustmentBuildingId,
      'inventory_adjustment_created_at': inventoryAdjustmentCreatedAt,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  InventoryAdjustmentModel copyWith({
    int? inventoryAdjustmentId,
    int? inventoryAdjustmentBusinessId,
    String? inventoryAdjustmentReason,
    String? inventoryAdjustmentNumber,
    double? inventoryAdjustmentAmount,
    int? inventoryAdjustmentBuildingId,
    String? inventoryAdjustmentCreatedAt,
  }) {
    return InventoryAdjustmentModel(
      inventoryAdjustmentId:
          inventoryAdjustmentId ?? this.inventoryAdjustmentId,
      inventoryAdjustmentBusinessId:
          inventoryAdjustmentBusinessId ?? this.inventoryAdjustmentBusinessId,
      inventoryAdjustmentReason:
          inventoryAdjustmentReason ?? this.inventoryAdjustmentReason,
      inventoryAdjustmentNumber:
          inventoryAdjustmentNumber ?? this.inventoryAdjustmentNumber,
      inventoryAdjustmentAmount:
          inventoryAdjustmentAmount ?? this.inventoryAdjustmentAmount,
      inventoryAdjustmentBuildingId:
          inventoryAdjustmentBuildingId ?? this.inventoryAdjustmentBuildingId,
      inventoryAdjustmentCreatedAt:
          inventoryAdjustmentCreatedAt ?? this.inventoryAdjustmentCreatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      inventoryAdjustmentId,
      inventoryAdjustmentBusinessId,
      inventoryAdjustmentReason,
      inventoryAdjustmentNumber,
      inventoryAdjustmentAmount,
      inventoryAdjustmentBuildingId,
      inventoryAdjustmentCreatedAt,
    ];
  }
}
