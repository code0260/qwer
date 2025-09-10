// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/data/model/place%20models/product_place_input_model.dart';

class EditProductCountModel {
  ProductPlaceInputModel productPlaceModel;
  String? reason;
  double? originalCount;
  int? originalUnitId;
  bool? isBiggerThanOriginal;
  EditProductCountModel({
    required this.productPlaceModel,
    this.reason,
    this.isBiggerThanOriginal,
  });

  Map<String, dynamic> toMap() {
    return {
      "product_place": productPlaceModel.toMap(),
      "original_count": originalCount,
      'original_unit_id': originalUnitId
    };
  }
}
