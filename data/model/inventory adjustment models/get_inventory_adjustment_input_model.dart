// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetInventoryAdjustmentInputModel {
  DateTime? startDate;
  DateTime? endDate;
  int? buildingsId;
  int? productId;

  GetInventoryAdjustmentInputModel({
    this.startDate,
    this.productId,
    this.endDate,
    this.buildingsId,
  });

  Map<String, dynamic> toServer() {
    Map<String, dynamic> map = {
      "start_date": startDate?.toUtc().toString().substring(0, 19),
      "end_date": endDate?.toUtc().toString().substring(0, 19),
      "buildings_id": buildingsId,
      "products_id": productId,
    };
    map.removeWhere(
        (key, value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  String toJson() {
    return jsonEncode(toServer());
  }

  @override
  bool operator ==(covariant GetInventoryAdjustmentInputModel other) {
    if (identical(this, other)) return true;

    return other.startDate == startDate &&
        other.endDate == endDate &&
        other.buildingsId == buildingsId &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    return startDate.hashCode ^
        endDate.hashCode ^
        buildingsId.hashCode ^
        productId.hashCode;
  }
}
