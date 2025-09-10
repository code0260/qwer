import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class TopDealingModel extends Equatable {
  final int? productsId;
  final String? productsName;
  final double? totalSoldBase;
  final String? unitsGroup;
  final double? totalSold;
  final String? unitName;
  final int? unitId;

  const TopDealingModel({
    this.productsId,
    this.productsName,
    this.totalSoldBase,
    this.unitsGroup,
    this.totalSold,
    this.unitName,
    this.unitId,
  });

  factory TopDealingModel.fromJson(Map<String, dynamic> json) {
    return TopDealingModel(
      productsId: json['products_id'] as int?,
      productsName: json['products_name'] as String?,
      totalSoldBase: receiveDouble(json['total_sold_base']),
      unitsGroup: json['units_group'] as String?,
      totalSold: receiveDouble(json['total_sold']),
      unitName: json['unit_name'] as String?,
      unitId: json['unit_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'products_id': productsId,
        'products_name': productsName,
        'total_sold_base': totalSoldBase,
        'units_group': unitsGroup,
        'total_sold': totalSold,
        'unit_name': unitName,
        'unit_id': unitId,
      };

  TopDealingModel copyWith({
    int? productsId,
    String? productsName,
    double? totalSoldBase,
    String? unitsGroup,
    double? totalSold,
    String? unitName,
    int? unitId,
  }) {
    return TopDealingModel(
      productsId: productsId ?? this.productsId,
      productsName: productsName ?? this.productsName,
      totalSoldBase: totalSoldBase ?? this.totalSoldBase,
      unitsGroup: unitsGroup ?? this.unitsGroup,
      totalSold: totalSold ?? this.totalSold,
      unitName: unitName ?? this.unitName,
      unitId: unitId ?? this.unitId,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      productsId,
      productsName,
      totalSoldBase,
      unitsGroup,
      totalSold,
      unitName,
      unitId,
    ];
  }
}
