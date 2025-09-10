class ProductStatementInputModel {
  int? productId;
  int? buildingsId;
  DateTime? startDate;
  DateTime? endDate;

  ProductStatementInputModel({
    this.productId,
    this.buildingsId,
    this.startDate,
    this.endDate,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'products_id': productId,
      'buildings_id': buildingsId,
      "start_date": startDate?.toUtc().toString().substring(0, 19),
      "end_date": endDate?.toUtc().toString().substring(0, 19),
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
