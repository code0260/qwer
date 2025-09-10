// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductTaxesInputModel {
  int? productTaxesId;
  int? productTaxesProductId;
  int? productTaxesTaxId;
  int? productTaxesOrder;
  String? productTaxesCreatedAt;
  int? taxesId;
  String? taxesName;
  String? taxesDescription;
  String? taxesRate;
  String? taxesType;
  int? taxesIsActive;
  String? taxesCreatedAt;
  String? taxesUpdatedAt;
  String? productTaxesApplicationLevel; // Added property
  int? taxesBusinessId; // Added property

  ProductTaxesInputModel({
    this.productTaxesId,
    this.productTaxesProductId,
    this.productTaxesTaxId,
    this.productTaxesOrder,
    this.productTaxesCreatedAt,
    this.taxesId,
    this.taxesName,
    this.taxesDescription,
    this.taxesRate,
    this.taxesType,
    this.taxesIsActive,
    this.taxesCreatedAt,
    this.taxesUpdatedAt,
    this.productTaxesApplicationLevel, // Added property
    this.taxesBusinessId, // Added property
  });

  factory ProductTaxesInputModel.fromJson(Map<String, dynamic> json) {
    return ProductTaxesInputModel(
      productTaxesId: json['product_taxes_id'] as int?,
      productTaxesProductId: json['product_taxes_product_id'] as int?,
      productTaxesTaxId: json['product_taxes_tax_id'] as int?,
      productTaxesOrder: json['product_taxes_order'] as int?,
      productTaxesCreatedAt: json['product_taxes_created_at'] as String?,
      taxesId: json['taxes_id'] as int?,
      taxesName: json['taxes_name'] as String?,
      taxesDescription: json['taxes_description'] as String?,
      taxesRate: json['taxes_rate'] as String?,
      taxesType: json['taxes_type'] as String?,
      taxesIsActive: json['taxes_is_active'] as int?,
      taxesCreatedAt: json['taxes_created_at'] as String?,
      taxesUpdatedAt: json['taxes_updated_at'] as String?,
      productTaxesApplicationLevel:
          json['product_taxes_application_level'] as String?, // Added property
      taxesBusinessId: json['taxes_business_id'] as int?, // Added property
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'product_taxes_id': productTaxesId,
      'product_taxes_product_id': productTaxesProductId,
      'product_taxes_tax_id': productTaxesTaxId,
      'product_taxes_order': productTaxesOrder,
      'product_taxes_created_at': productTaxesCreatedAt,
      'taxes_id': taxesId,
      'taxes_name': taxesName,
      'taxes_description': taxesDescription,
      'taxes_rate': taxesRate,
      'taxes_type': taxesType,
      'taxes_is_active': taxesIsActive,
      'taxes_created_at': taxesCreatedAt,
      'taxes_updated_at': taxesUpdatedAt,
      'product_taxes_application_level':
          productTaxesApplicationLevel, // Added property
      'taxes_business_id': taxesBusinessId, // Added property
    };
    map.removeWhere(
      (key, value) => value == null,
    );
    return map;
  }
}
