// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:almonazim/core/constant/app_enums.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';
import 'package:almonazim/data/model/place%20models/product_place_model.dart';

class MoveProductModel {
  PlaceModel originalPlaceInputModel;
  PlaceModel newPlaceInputModel;
  late ProductPlaceModel productPlaceModel;
  late MovementDirection movementDirection;
  double? count;
  int? unitId;
  int? productsId;
  double? conversion;
  String? reason;
  MoveProductModel({
    required this.originalPlaceInputModel,
    required this.newPlaceInputModel,
    this.count,
    this.productsId,
    this.unitId,
    this.reason,
    this.conversion,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'original_place_model': originalPlaceInputModel.toMap(),
      'new_place_model': newPlaceInputModel.toMap(),
      'product_place_model': productPlaceModel.toJson(),
      'movement_direction': movementDirection.name,
      'products_movement_count': count,
      'products_movement_count_unit_id': unitId,
      'products_id': productsId,
      'conversion': conversion,
      'products_movement_count_reason': reason,
    };
    map.removeWhere((key, value) => value == null || value == "");
    return map;
  }

  String toJson() => json.encode(toMap());
}
