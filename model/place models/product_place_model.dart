import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';

class ProductPlaceModel {
  final int? productPlacesId;
  final int? productPlacesProductsId;
  final double? productPlacesCount;
  final int? productPlacesCountUnitId;
  final int? productPlacesBatchesId;
  final int? productPlacesPlacesId;

  ProductPlaceModel({
    this.productPlacesId,
    this.productPlacesProductsId,
    this.productPlacesCount,
    this.productPlacesCountUnitId,
    this.productPlacesBatchesId,
    this.productPlacesPlacesId,
  });

  factory ProductPlaceModel.fromJson(Map<String, dynamic> json) =>
      ProductPlaceModel(
        productPlacesId: json['product_places_id'],
        productPlacesProductsId: json['product_places_products_id'],
        productPlacesCount: receiveDouble(json['product_places_count']),
        productPlacesCountUnitId: json['product_places_count_unit_id'],
        productPlacesBatchesId: json['product_places_batches_id'],
        productPlacesPlacesId: json['product_places_places_id'],
      );

  Map<String, dynamic> toJson() => {
        'product_places_id': productPlacesId,
        'product_places_products_id': productPlacesProductsId,
        'product_places_count': productPlacesCount,
        'product_places_count_unit_id': productPlacesCountUnitId,
        'product_places_batches_id': productPlacesBatchesId,
        'product_places_places_id': productPlacesPlacesId,
      };
}
