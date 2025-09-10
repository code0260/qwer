import 'package:equatable/equatable.dart';
import 'package:almonazim/data/model/batch_model.dart';
import 'package:almonazim/data/model/place%20models/place_model.dart';
import 'package:almonazim/data/model/place%20models/product_place_model.dart';

class ProductPlaceDetailsModel extends Equatable {
  final BatchModel batchModel;
  final PlaceModel placeModel;
  final ProductPlaceModel productPlaceModel;

  const ProductPlaceDetailsModel(
      {required this.batchModel,
      required this.placeModel,
      required this.productPlaceModel});

  factory ProductPlaceDetailsModel.fromJson(Map<String, dynamic> map) {
    return ProductPlaceDetailsModel(
      batchModel: BatchModel.fromJson(map['batch'] as Map<String, dynamic>),
      placeModel: PlaceModel.fromJson(map['place'] as Map<String, dynamic>),
      productPlaceModel: ProductPlaceModel.fromJson(
          map['product_place'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object> get props => [batchModel, placeModel, productPlaceModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'batch': batchModel.toServerMap(),
      'place': placeModel.toMap(),
      'product_place': productPlaceModel.toJson(),
    };
  }
}
