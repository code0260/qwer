import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class StockModel extends Equatable {
  final int? stockId;
  final int? stockProductsId;
  final int? stockBuildingsId;
  final String? stockCurrentCount;
  final int? stockCurrentCountUnitId;
  final String? stockCurrentCountUpdatedAt;
  final int? stockReorderPoint;
  final int? stockReorderPointUnitId;
  final String? stockReorderPointUpdatedAt;
  final double? unitsConversionFactor;
  final double? marketValue;
  final double? wac;
  final double? totalCost;

  const StockModel({
    this.stockId,
    this.stockProductsId,
    this.stockBuildingsId,
    this.stockCurrentCount,
    this.stockCurrentCountUnitId,
    this.stockCurrentCountUpdatedAt,
    this.stockReorderPoint,
    this.stockReorderPointUnitId,
    this.stockReorderPointUpdatedAt,
    this.unitsConversionFactor,
    this.marketValue,
    this.wac,
    this.totalCost,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        stockId: json['stock_id'] as int?,
        stockProductsId: json['stock_products_id'] as int?,
        stockBuildingsId: json['stock_buildings_id'] as int?,
        stockCurrentCount: json['stock_current_count'] as String?,
        stockCurrentCountUnitId: json['stock_current_count_unit_id'] as int?,
        stockCurrentCountUpdatedAt:
            json['stock_current_count_updated_at'] as String?,
        stockReorderPoint: json['stock_reorder_point'] as int?,
        stockReorderPointUnitId: json['stock_reorder_point_unit_id'] as int?,
        stockReorderPointUpdatedAt:
            json['stock_reorder_point_updated_at'] as String?,
        unitsConversionFactor: receiveDouble(json['units_conversion_factor']),
        marketValue: receiveDouble(json['market_value']),
        wac: receiveDouble(json["wac"]),
        totalCost: receiveDouble(json['total_cost']),
      );

  Map<String, dynamic> toJson() => {
        'stock_id': stockId,
        'stock_products_id': stockProductsId,
        'stock_buildings_id': stockBuildingsId,
        'stock_current_count': stockCurrentCount,
        'stock_current_count_unit_id': stockCurrentCountUnitId,
        'stock_current_count_updated_at': stockCurrentCountUpdatedAt,
        'stock_reorder_point': stockReorderPoint,
        'stock_reorder_point_unit_id': stockReorderPointUnitId,
        'stock_reorder_point_updated_at': stockReorderPointUpdatedAt,
        'units_conversion_factor': unitsConversionFactor,
        'market_value': marketValue,
        'wac': wac,
        'total_cost': totalCost,
      };

  @override
  List<Object?> get props {
    return [
      stockId,
      stockProductsId,
      stockBuildingsId,
      stockCurrentCount,
      stockCurrentCountUnitId,
      stockCurrentCountUpdatedAt,
      stockReorderPoint,
      stockReorderPointUnitId,
      stockReorderPointUpdatedAt,
      unitsConversionFactor,
      marketValue,
      wac,
      totalCost,
    ];
  }
}
