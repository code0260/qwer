// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductPlaceInputModel {
  int? productPlacesId;
  int? productPlacesProductsId;
  double? productPlacesCount;
  int? productPlacesCountUnitId;
  int? productPlacesBatchesId;
  int? productPlacesPlacesId;
  ProductPlaceInputModel({
    this.productPlacesId,
    this.productPlacesProductsId,
    this.productPlacesCount,
    this.productPlacesCountUnitId,
    this.productPlacesBatchesId,
    this.productPlacesPlacesId,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'product_places_id': productPlacesId,
      'product_places_products_id': productPlacesProductsId,
      'product_places_count': productPlacesCount,
      'product_places_count_unit_id': productPlacesCountUnitId,
      'product_places_batches_id': productPlacesBatchesId,
      'product_places_places_id': productPlacesPlacesId,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
