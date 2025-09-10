import 'dart:convert';

import 'package:almonazim/core/extension/string_extensions.dart';
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class InvoiceItemsModel extends Equatable {
  final int? invoicesItemsId;
  final int? invoicesItemsProductsId;
  final double? invoicesItemsProductsCount;
  final String? invoicesItemsTotalProductPrice;
  final String? invoicesItemsCountForEachPlace;
  final int? invoicesItemsPricesId;
  final int? invoicesItemsInvoices;
  final int? invoicesItemsCountUnitId;
  final String? productsName;
  final String? unitsName;
  final double? unitsConversionFactor;
  final String? unitsSymbol;
  final double? unitPrice; // Added property
  final String? invoicesItemsProductPlaces; // Added property
  final double? invoicesItemsTaxAmount; // New property
  final double? invoicesItemsDiscount; // New property

  const InvoiceItemsModel({
    this.invoicesItemsCountUnitId,
    this.unitsSymbol,
    this.unitsName,
    this.unitsConversionFactor,
    this.productsName,
    this.invoicesItemsCountForEachPlace,
    this.invoicesItemsId,
    this.invoicesItemsProductsId,
    this.invoicesItemsProductsCount,
    this.invoicesItemsTotalProductPrice,
    this.invoicesItemsPricesId,
    this.invoicesItemsInvoices,
    this.unitPrice, // Added property
    this.invoicesItemsProductPlaces, // Added property
    this.invoicesItemsTaxAmount, // New property
    this.invoicesItemsDiscount, // New property
  });

  factory InvoiceItemsModel.fromJson(Map<String, dynamic> json) {
    return InvoiceItemsModel(
      invoicesItemsCountUnitId: json['invoices_items_count_unit_id'] as int?,
      unitsName: json['units_name'] as String?,
      unitsSymbol: json['units_symbol'] as String?,
      unitsConversionFactor: receiveDouble(json['units_conversion_factor']),
      productsName: json['products_name'] as String?,
      invoicesItemsId: json['invoices_items_id'] as int?,
      invoicesItemsProductsId: json['invoices_items_productsid'] as int?,
      invoicesItemsProductsCount:
          (json['invoices_items_products_count'] as num?)?.toDouble(),
      invoicesItemsTotalProductPrice:
          json['invoices_items_total_product_price'] as String?,
      invoicesItemsCountForEachPlace:
          json['invoices_items_count_for_each_place'] as String?,
      invoicesItemsPricesId: json['invoices_items_prices_id'] as int?,
      invoicesItemsInvoices: json['invoices_items_invoices'] as int?,
      unitPrice: (json['unit_price'] as num?)?.toDouble(), // Added property
      invoicesItemsProductPlaces:
          json['invoices_items_product_places'] as String?, // Added property
      invoicesItemsTaxAmount: (json['invoices_items_tax_amount'] as String?)
          ?.toDouble(), // New property
      invoicesItemsDiscount:
          (json['invoices_items_discount'] as num?)?.toDouble(), // New property
    );
  }

  Map<String, dynamic> toJson() => {
        'products_name': productsName,
        'invoices_items_id': invoicesItemsId,
        'invoices_items_productsid': invoicesItemsProductsId,
        'invoices_items_products_count': invoicesItemsProductsCount,
        'invoices_items_total_product_price': invoicesItemsTotalProductPrice,
        'invoices_items_count_for_each_place': invoicesItemsCountForEachPlace,
        "invoices_items_count_unit_id": invoicesItemsCountUnitId,
        'invoices_items_prices_id': invoicesItemsPricesId,
        'invoices_items_invoices': invoicesItemsInvoices,
        'unit_price': unitPrice, // Added property
        'invoices_items_product_places':
            invoicesItemsProductPlaces, // Added property
        'invoices_items_tax_amount': invoicesItemsTaxAmount, // New property
        'invoices_items_discount': invoicesItemsDiscount, // New property
      };

  String toServerJson() {
    final Map<String, dynamic> map = {
      'invoices_items_id': invoicesItemsId,
      'invoices_items_productsid': invoicesItemsProductsId,
      'invoices_items_products_count': invoicesItemsProductsCount,
      'invoices_items_total_product_price': invoicesItemsTotalProductPrice,
      "invoices_items_count_unit_id": invoicesItemsCountUnitId,
      'invoices_items_prices_id': invoicesItemsPricesId,
      'invoices_items_invoices': invoicesItemsInvoices,
      'invoices_items_count_for_each_place': invoicesItemsCountForEachPlace,
      'invoices_items_product_places':
          invoicesItemsProductPlaces, // Added property
      'invoices_items_tax_amount': invoicesItemsTaxAmount, // New property
      'invoices_items_discount': invoicesItemsDiscount, // New property
    };
    // Remove entries with null values
    map.removeWhere((key, value) => value == null);
    return jsonEncode(map);
  }

  Map<String, dynamic> toServerMap() {
    final Map<String, dynamic> map = {
      'invoices_items_id': invoicesItemsId,
      'invoices_items_productsid': invoicesItemsProductsId,
      'invoices_items_products_count': invoicesItemsProductsCount,
      'invoices_items_total_product_price': invoicesItemsTotalProductPrice,
      "invoices_items_count_unit_id": invoicesItemsCountUnitId,
      'invoices_items_prices_id': invoicesItemsPricesId,
      'invoices_items_invoices': invoicesItemsInvoices,
      'invoices_items_count_for_each_place': invoicesItemsCountForEachPlace,
      'invoices_items_product_places':
          invoicesItemsProductPlaces, // Added property
      'invoices_items_tax_amount': invoicesItemsTaxAmount, // New property
      'invoices_items_discount': invoicesItemsDiscount, // New property
    };
    // Remove entries with null values
    map.removeWhere((key, value) => value == null);
    return map;
  }

  InvoiceItemsModel copyWith({
    String? productsName,
    int? invoicesItemsId,
    int? invoicesItemsProductsId,
    double? invoicesItemsProductsCount,
    String? invoicesItemsTotalProductPrice,
    String? invoicesItemsCountForEachPlace,
    int? invoicesItemsInvoices,
    String? invoicesItemsProductPlaces, // Added property
    double? invoicesItemsTaxAmount, // New property
    double? invoicesItemsDiscount, // New property
  }) {
    return InvoiceItemsModel(
      productsName: productsName ?? this.productsName,
      invoicesItemsId: invoicesItemsId ?? this.invoicesItemsId,
      invoicesItemsProductsId:
          invoicesItemsProductsId ?? invoicesItemsProductsId,
      invoicesItemsProductsCount:
          invoicesItemsProductsCount ?? this.invoicesItemsProductsCount,
      invoicesItemsTotalProductPrice:
          invoicesItemsTotalProductPrice ?? this.invoicesItemsTotalProductPrice,
      invoicesItemsCountForEachPlace:
          invoicesItemsCountForEachPlace ?? this.invoicesItemsCountForEachPlace,
      invoicesItemsInvoices:
          invoicesItemsInvoices ?? this.invoicesItemsInvoices,
      invoicesItemsProductPlaces: invoicesItemsProductPlaces ??
          this.invoicesItemsProductPlaces, // Added property
      invoicesItemsTaxAmount:
          invoicesItemsTaxAmount ?? this.invoicesItemsTaxAmount, // New property
      invoicesItemsDiscount:
          invoicesItemsDiscount ?? this.invoicesItemsDiscount, // New property
    );
  }

  @override
  List<Object?> get props {
    return [
      productsName,
      invoicesItemsId,
      invoicesItemsProductsId,
      invoicesItemsProductsCount,
      invoicesItemsTotalProductPrice,
      invoicesItemsInvoices,
      unitsConversionFactor,
      invoicesItemsCountForEachPlace,
      unitsName,
      unitsSymbol,
      invoicesItemsCountUnitId,
      invoicesItemsPricesId,
      unitPrice, // Added property
      invoicesItemsProductPlaces, // Added property
      invoicesItemsTaxAmount, // New property
      invoicesItemsDiscount, // New property
    ];
  }
}
