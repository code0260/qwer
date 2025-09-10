import 'package:almonazim/core/helper/functions/datetime%20functions/to_local_datetime.dart';
import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class BatchModel extends Equatable {
  int? batchesId;
  int? batchesProductsId;
  int? batchesInvoicesId;
  int? batchesActive;
  double? batchesProductsBuyPrice;
  String? batchesExpirationDate;
  double? batchesProductsTotalCount;
  double? batchesProductsOriginalTotalCount;
  double? batchesProductsRemainingCount;
  int? batchesCountUnitId;
  String? unitsName;
  double? unitsConversionFactor;
  String? unitsSymbol;
  int? batchesImportersId;
  String? batchesCreatedAt;
  int? batchesProductsPricesId;
  double? batchesProductUnitCost;
  int? placeId;
  int? batchesProductsCurrencyId; // New property added

  BatchModel({
    this.batchesId,
    this.batchesProductsId,
    this.batchesInvoicesId,
    this.batchesActive,
    this.unitsSymbol,
    this.unitsName,
    this.placeId,
    this.batchesProductsOriginalTotalCount,
    this.unitsConversionFactor,
    this.batchesProductsBuyPrice,
    this.batchesExpirationDate,
    this.batchesProductsTotalCount,
    this.batchesProductsRemainingCount,
    this.batchesImportersId,
    this.batchesCreatedAt,
    this.batchesCountUnitId,
    this.batchesProductsPricesId,
    this.batchesProductUnitCost,
    this.batchesProductsCurrencyId, // Initialize new property
  });

  factory BatchModel.fromJson(Map<String, dynamic> json) => BatchModel(
        batchesId: json['batches_id'] as int?,
        batchesProductsId: json['batches_products_id'] as int?,
        placeId: json['places_id'] as int?,
        batchesInvoicesId: json['batches_invoices_id'] as int?,
        batchesActive: json['batches_active'] as int?,
        batchesProductsBuyPrice:
            receiveDouble(json['batches_products_buy_price']),
        batchesExpirationDate: json['batches_expiration_date'] != null
            ? DateTime.parse('${json['batches_expiration_date']}Z')
                .toLocal()
                .toString()
            : null,
        batchesProductsTotalCount:
            (json['batches_products_total_count'] as num?)?.toDouble(),
        batchesProductsOriginalTotalCount:
            (json['batches_products_total_count'] as num?)?.toDouble(),
        batchesProductsRemainingCount:
            (json['batches_products_remaining_count'] as num?)?.toDouble(),
        batchesImportersId: json['batches_importers_id'] as int?,
        batchesCountUnitId: json['batches_count_unit_id'] as int?,
        unitsName: json['units_name'] as String?,
        unitsSymbol: json['units_symbol'] as String?,
        unitsConversionFactor: receiveDouble(json['units_conversion_factor']),
        batchesCreatedAt: toLocalTime(json['batches_createdAt']),
        batchesProductsPricesId: json['batches_products_prices_id'] as int?,
        batchesProductUnitCost:
            receiveDouble(json['batches_product_unit_cost']),
        batchesProductsCurrencyId: json['batches_products_currency_id']
            as int?, // Deserialize new property
      );

  Null get batchesProductsBuyEditPrice => null;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'places_id': placeId,
      'batches_id': batchesId,
      'batches_products_id': batchesProductsId,
      'batches_invoices_id': batchesInvoicesId,
      'batches_active': batchesActive,
      'batches_products_buy_price': batchesProductsBuyPrice,
      'batches_expiration_date': batchesExpirationDate != null
          ? DateTime.parse(batchesExpirationDate!).toUtc().toString()
          : null,
      'batches_products_total_count': batchesProductsTotalCount,
      'batches_products_remaining_count': batchesProductsRemainingCount,
      'batches_count_unit_id': batchesCountUnitId,
      'batches_importers_id': batchesImportersId,
      'batches_createdAt': batchesCreatedAt != null
          ? DateTime.parse(batchesCreatedAt!).toUtc().toString()
          : null,
      'batches_products_prices_id': batchesProductsPricesId,
      'batches_product_unit_cost': batchesProductUnitCost,
      'batches_products_currency_id':
          batchesProductsCurrencyId, // Serialize new property
    };
    data.removeWhere((key, value) => value == null);
    return data;
  }

  Map<String, dynamic> toServerMap() {
    final Map<String, dynamic> map = {
      'batches_id': batchesId,
      'batches_products_id': batchesProductsId,
      'places_id': placeId,
      'batches_invoices_id': batchesInvoicesId,
      'batches_active': batchesActive,
      'batches_products_buy_price': batchesProductsBuyPrice,
      'batches_expiration_date': batchesExpirationDate != null
          ? DateTime.parse(batchesExpirationDate!).toUtc().toString()
          : null,
      'batches_products_total_count': batchesProductsTotalCount,
      'batches_products_remaining_count':
          batchesProductsRemainingCount ?? batchesProductsTotalCount,
      'batches_count_unit_id': batchesCountUnitId,
      'batches_importers_id': batchesImportersId,
      'batches_product_unit_cost': batchesProductUnitCost,
      'batches_products_prices_id': batchesProductsPricesId ?? 0,
      'batches_products_currency_id': batchesProductsCurrencyId,
      'units_conversion_factor': unitsConversionFactor
    };
    map.removeWhere((key, value) => value == null);
    // if (map["batches_products_prices_id"] != 0) {
    //   map.remove("batches_products_buy_price");
    // }
    return map;
  }

  BatchModel copyWith({
    int? batchesId,
    int? batchesProductsId,
    int? batchesInvoicesId,
    int? batchesActive,
    double? batchesProductsBuyPrice,
    double? batchesProductsRemainingCount,
    String? batchesExpirationDate,
    double? batchesProductsTotalCount,
    int? batchesCountUnitId,
    int? batchesImportersId,
    String? unitsName,
    String? unitsSymbol,
    double? unitsConversionFactor,
    String? batchesCreatedAt,
    int? batchesProductsPricesId,
    double? batchesProductUnitCost,
    int? batchesProductsCurrencyId, // Add to copyWith
  }) {
    return BatchModel(
      batchesId: batchesId ?? this.batchesId,
      batchesProductsId: batchesProductsId ?? this.batchesProductsId,
      batchesInvoicesId: batchesInvoicesId ?? this.batchesInvoicesId,
      batchesActive: batchesActive ?? this.batchesActive,
      batchesProductsBuyPrice:
          batchesProductsBuyPrice ?? this.batchesProductsBuyPrice,
      batchesProductsRemainingCount:
          batchesProductsRemainingCount ?? this.batchesProductsRemainingCount,
      batchesExpirationDate:
          batchesExpirationDate ?? this.batchesExpirationDate,
      batchesProductsTotalCount:
          batchesProductsTotalCount ?? this.batchesProductsTotalCount,
      batchesCountUnitId: batchesCountUnitId ?? this.batchesCountUnitId,
      batchesImportersId: batchesImportersId ?? this.batchesImportersId,
      unitsName: unitsName ?? this.unitsName,
      unitsSymbol: unitsSymbol ?? this.unitsSymbol,
      unitsConversionFactor:
          unitsConversionFactor ?? this.unitsConversionFactor,
      batchesCreatedAt: batchesCreatedAt ?? this.batchesCreatedAt,
      batchesProductsPricesId:
          batchesProductsPricesId ?? this.batchesProductsPricesId,
      batchesProductUnitCost:
          batchesProductUnitCost ?? this.batchesProductUnitCost,
      batchesProductsCurrencyId: batchesProductsCurrencyId ??
          this.batchesProductsCurrencyId, // Assign new property
    );
  }

  @override
  List<Object?> get props {
    return [
      batchesId,
      batchesProductsId,
      batchesInvoicesId,
      batchesActive,
      batchesProductsBuyPrice,
      batchesExpirationDate,
      batchesProductsTotalCount,
      batchesProductsRemainingCount,
      batchesCountUnitId,
      unitsName,
      unitsSymbol,
      unitsConversionFactor,
      batchesImportersId,
      batchesCreatedAt,
      batchesProductsPricesId,
      batchesProductUnitCost,
      batchesProductsCurrencyId, // Add to props
    ];
  }
}
