import 'dart:convert';

import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BuyRefundItemModel {
  int? productsId;
  String? productsName;
  double? productsCount;
  String? unitsName;
  int? productsCountUnitId;
  double? buyPrice;
  double? unitsConversionFactor;
  String? unitsSymbol;
  // original
  double? originalCount;
  String? originalUnitsConversionFactor;

  BuyRefundItemModel({
    this.productsId,
    this.productsName,
    this.productsCount,
    this.unitsName,
    this.productsCountUnitId,
    this.buyPrice,
    this.unitsConversionFactor,
    this.unitsSymbol,
    this.originalCount,
    this.originalUnitsConversionFactor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'invoices_items_productsid': productsId,
      'products_name': productsName,
      'invoices_items_products_count': productsCount,
      'units_name': unitsName,
      'invoices_items_count_unit_id': productsCountUnitId,
      'prices_unit_price': buyPrice,
      'units_conversion_factor': unitsConversionFactor,
      'units_symbol': unitsSymbol,
    };
  }

  factory BuyRefundItemModel.fromMap(Map<String, dynamic> map) {
    return BuyRefundItemModel(
      productsId: map['invoices_items_productsid'] != null
          ? map['invoices_items_productsid'] as int
          : null,
      productsName:
          map['products_name'] != null ? map['products_name'] as String : null,
      productsCount: map['invoices_items_products_count'] != null
          ? (map['invoices_items_products_count'])!.toDouble() as double
          : null,
      originalCount: map['invoices_items_products_count'] != null
          ? (map['invoices_items_products_count'])!.toDouble() as double
          : null,
      unitsName: map['units_name'] != null ? map['units_name'] as String : null,
      productsCountUnitId: map['invoices_items_count_unit_id'] != null
          ? map['invoices_items_count_unit_id'] as int
          : null,
      buyPrice: map['prices_unit_price'] != null
          ? (map['prices_unit_price'])!.toDouble() as double
          : null,
      unitsConversionFactor: receiveDouble(map['units_conversion_factor']),
      originalUnitsConversionFactor: map['units_conversion_factor'] != null
          ? map['units_conversion_factor'] as String
          : null,
      unitsSymbol:
          map['units_symbol'] != null ? map['units_symbol'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BuyRefundItemModel.fromJson(String source) =>
      BuyRefundItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
