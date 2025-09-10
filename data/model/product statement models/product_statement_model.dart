import 'package:almonazim/data/model/product%20statement%20models/product_statement_deal_model..dart';
import 'package:almonazim/data/model/product%20statement%20models/product_statement_summary_model.dart';

class ProductStatementModel {
  final ProductStatementSummaryModel productStatementSummaryModel;
  final List<ProductStatementDealModel> deals;
  final String buildingName;
  final String productName;
  ProductStatementModel(
      {required this.productStatementSummaryModel,
      required this.buildingName,
      required this.productName,
      required this.deals});

  factory ProductStatementModel.fromJson(Map<String, dynamic> map) {
    return ProductStatementModel(
      buildingName: map['buildings_name'],
      productName: map['products_name'],
      deals: List<ProductStatementDealModel>.from(
        (map['deals'] as List<dynamic>).map<ProductStatementDealModel>(
          (x) => ProductStatementDealModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      productStatementSummaryModel: ProductStatementSummaryModel.fromJson(
          map['summary'] as Map<String, dynamic>),
    );
  }
}
