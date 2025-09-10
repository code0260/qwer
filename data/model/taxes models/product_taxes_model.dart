// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:almonazim/data/model/product models/product_model.dart';
import 'package:almonazim/data/model/taxes%20models/product_tax_model.dart';

class ProductTaxesModel {
  final ProductModel productModel;
  final List<ProductTaxModel> taxes;
  ProductTaxesModel({
    required this.productModel,
    required this.taxes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productModel': productModel.toJson(),
      'taxes': taxes.map((x) => x.toJson()).toList(),
    };
  }

  factory ProductTaxesModel.fromJson(Map<String, dynamic> map) {
    return ProductTaxesModel(
      productModel:
          ProductModel.fromJson(map['productModel'] as Map<String, dynamic>),
      taxes: List<ProductTaxModel>.from(
        (map['taxes'] as List<int>).map<ProductTaxModel>(
          (x) => ProductTaxModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
