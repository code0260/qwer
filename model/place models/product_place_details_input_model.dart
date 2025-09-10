import 'package:almonazim/data/model/place%20models/place_input_model.dart';
import 'package:almonazim/data/model/place%20models/product_place_input_model.dart';
import 'package:equatable/equatable.dart';

class ProductPlaceDetailsInputModel extends Equatable {
  final PlaceInputModel placeModel;
  final ProductPlaceInputModel productPlaceModel;

  const ProductPlaceDetailsInputModel(
      {required this.placeModel, required this.productPlaceModel});

  Map toMap() {
    Map data = {
      "place": placeModel.toMap(),
      "product_place": productPlaceModel.toMap()
    };
    return data;
  }

  @override
  List<Object> get props => [placeModel, productPlaceModel];
}
