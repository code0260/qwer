class StockInputModel {
  int? stockId;
  int? stockProductsId;
  int? stockBuildingsId;
  String? stockCurrentCount;
  int? stockCurrentCountUnitId;
  String? stockCurrentCountUpdatedAt;
  double? stockReorderPoint;
  int? stockReorderPointUnitId;
  String? stockReorderPointUpdatedAt;

  StockInputModel({
    this.stockId,
    this.stockProductsId,
    this.stockBuildingsId,
    this.stockCurrentCount,
    this.stockCurrentCountUnitId,
    this.stockCurrentCountUpdatedAt,
    this.stockReorderPoint,
    this.stockReorderPointUnitId,
    this.stockReorderPointUpdatedAt,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'stock_id': stockId,
      'stock_products_id': stockProductsId,
      'stock_buildings_id': stockBuildingsId,
      'stock_current_count': stockCurrentCount,
      'stock_current_count_unit_id': stockCurrentCountUnitId,
      'stock_current_count_updated_at': stockCurrentCountUpdatedAt,
      'stock_reorder_point': stockReorderPoint,
      'stock_reorder_point_unit_id': stockReorderPointUnitId,
      'stock_reorder_point_updated_at': stockReorderPointUpdatedAt,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
