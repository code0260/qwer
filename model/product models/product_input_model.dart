// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductInputModel {
  int? productsId;
  String? productsName;
  String? productsDescription;
  String? productsBarcode;
  int? productsBusinessId;
  int? productsActive;
  int? productsBaseUnitId;
  int? productsCategories;
  String? productsType; // Added property
  int? productsOnline;
  int? productsProfitPercentage;

  ProductInputModel(
      {this.productsId,
      this.productsName,
      this.productsDescription,
      this.productsBarcode,
      this.productsActive,
      this.productsBaseUnitId,
      this.productsCategories,
      this.productsBusinessId,
      this.productsType, // Added property
      this.productsProfitPercentage,
      this.productsOnline});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'products_id': productsId,
      'products_name': productsName,
      'products_description': productsDescription,
      'products_active': productsActive,
      'products_barcode': productsBarcode,
      'products_base_unit_id': productsBaseUnitId,
      'products_categories': productsCategories,
      'products_type': productsType, // Added property
      'products_online': productsOnline,
      'products_business_id': productsBusinessId,
      'products_profit_percentage': productsProfitPercentage, // Added to toJson
    };
    map.removeWhere((key, value) => value == null);
    if (map['products_profit_percentage'] != null &&
        map['products_profit_percentage'] == 200) {
      map['products_profit_percentage'] = null;
    }
    return map;
  }
}
