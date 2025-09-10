import 'package:almonazim/core/helper/functions/other functions/receive_double.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProductModel extends Equatable {
  final int? productsId;
  final int? productsCategories;
  final int? productsBusinessId;
  final String? productsName;
  final String? productsDescription;
  final String? productsBarcode;
  final double? lastPrice;
  final int? productsBaseUnitId;
  final String? unitsBaseName;
  final double? unitsBaseConversion;
  final int? productsActive;
  final String? productsType; // Added property
  final int? lastPriceCurrencyId;
  final int? pricesId;
  int? favorite;
  final int? productsProfitPercentage;

  ProductModel({
    this.favorite,
    this.productsId,
    this.productsCategories,
    this.productsBusinessId,
    this.productsName,
    this.productsDescription,
    this.productsBarcode,
    this.lastPrice,
    this.pricesId,
    this.productsBaseUnitId,
    this.unitsBaseName,
    this.unitsBaseConversion,
    this.productsActive,
    this.productsType, // Added property
    this.lastPriceCurrencyId,
    this.productsProfitPercentage, // Added to the constructor
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productsId: json['products_id'] as int?,
        productsBusinessId: json['products_business_id'] as int?,
        productsCategories: json['products_categories'] as int?,
        productsName: json['products_name'] as String?,
        favorite: json['favorite'] as int?,
        productsDescription: json['products_description'] as String?,
        productsBarcode: json['products_barcode'] as String?,
        lastPrice: receiveDouble(json['last_price']),
        productsBaseUnitId: json['products_base_unit_id'] as int?,
        unitsBaseName: json['units_base_name'] as String?,
        unitsBaseConversion: receiveDouble(json['units_base_conversion']),
        productsActive: json['products_active'] as int?,
        productsType: json['products_type'] as String?,
        pricesId: json['prices_id'] as int?,
        lastPriceCurrencyId: json['last_price_currency_id'] as int?,
        productsProfitPercentage:
            json['products_profit_percentage'] as int?, // Added to fromJson
      );

  Map<String, dynamic> toJson() => {
        'products_id': productsId,
        'products_business_id': productsBusinessId,
        'products_name': productsName,
        'products_barcode': productsBarcode,
        'last_price': lastPrice,
        'products_base_unit_id': productsBaseUnitId,
        'units_base_name': unitsBaseName,
        'units_base_conversion': unitsBaseConversion,
        'products_active': productsActive,
        'products_type': productsType, // Added property
        'last_price_currency_id': lastPriceCurrencyId,
        'products_profit_percentage':
            productsProfitPercentage, // Added to toJson
      };

  Map<String, dynamic> toMap() {
    var map = {
      'products_id': productsId,
      'products_business_id': productsBusinessId,
      'products_name': productsName,
      'products_type': productsType,
      'products_active': productsActive,
      'last_price': lastPrice,
      'prices_id': pricesId,
      'products_barcode': productsBarcode,
      'products_base_unit_id': productsBaseUnitId,
      'products_categories': productsCategories,
      'last_price_currency_id': lastPriceCurrencyId,
      'units_base_conversion': unitsBaseConversion,
      'products_profit_percentage': productsProfitPercentage, // Added to toMap
    };
    map.removeWhere(
      (key, value) => value == null,
    );
    return map;
  }

  ProductModel copyWith({
    int? productsId,
    int? productsBusinessId,
    String? productsName,
    String? productsBarcode,
    double? lastPrice,
    int? productsBaseUnitId,
    String? unitsBaseName,
    double? unitsBaseConversion,
    int? productsActive,
    int? pricesId,
    int? lastPriceCurrencyId,
    String? productsType,
    int? productsProfitPercentage, // Added to copyWith parameters
  }) {
    return ProductModel(
      productsId: productsId ?? this.productsId,
      pricesId: pricesId ?? this.pricesId,
      productsBusinessId: productsBusinessId ?? this.productsBusinessId,
      productsName: productsName ?? this.productsName,
      productsBarcode: productsBarcode ?? this.productsBarcode,
      lastPrice: lastPrice ?? this.lastPrice,
      productsBaseUnitId: productsBaseUnitId ?? this.productsBaseUnitId,
      unitsBaseName: unitsBaseName ?? this.unitsBaseName,
      unitsBaseConversion: unitsBaseConversion ?? this.unitsBaseConversion,
      productsActive: productsActive ?? this.productsActive,
      productsType: productsType ?? this.productsType,
      lastPriceCurrencyId: lastPriceCurrencyId ?? this.lastPriceCurrencyId,
      productsProfitPercentage: productsProfitPercentage ??
          this.productsProfitPercentage, // Added to copyWith body
    );
  }

  @override
  List<Object?> get props {
    return [
      productsId,
      productsBusinessId,
      unitsBaseConversion,
      productsName,
      pricesId,
      productsBarcode,
      lastPrice,
      productsBaseUnitId,
      unitsBaseName,
      productsActive,
      productsType,
      lastPriceCurrencyId,
      productsProfitPercentage, // Added to props
    ];
  }
}
