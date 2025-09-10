import 'package:equatable/equatable.dart';

class ProductTaxModel extends Equatable {
  final int? productTaxesId;
  final int? productTaxesProductId;
  final int? productTaxesTaxId;
  final int? productTaxesOrder;
  final String? productTaxesCreatedAt;
  final int? taxesId;
  final String? taxesName;
  final String? taxesDescription;
  final String? taxesRate;
  final String? taxesType;
  final int? taxesIsActive;
  final String? taxesCreatedAt;
  final String? taxesUpdatedAt;
  final String? productTaxesApplicationLevel; // Added property
  final int? taxesBusinessId; // Added property

  const ProductTaxModel({
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

  factory ProductTaxModel.fromJson(Map<String, dynamic> json) {
    return ProductTaxModel(
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

  Map<String, dynamic> toStoring() => {
        'product_taxes_id': productTaxesId,
        'product_taxes_product_id': productTaxesProductId,
        'product_taxes_tax_id': productTaxesTaxId,
        'product_taxes_order': productTaxesOrder,
        'product_taxes_created_at': productTaxesCreatedAt,
        'product_taxes_application_level':
            productTaxesApplicationLevel, // Added property
      };

  Map<String, dynamic> toJson() => {
        'product_taxes_id': productTaxesId,
        'product_taxes_product_id': productTaxesProductId,
        'product_taxes_tax_id': productTaxesTaxId,
        'product_taxes_order': productTaxesOrder,
        'product_taxes_created_at': productTaxesCreatedAt,
        'product_taxes_application_level':
            productTaxesApplicationLevel, // Added property
        'taxes_id': taxesId,
        'taxes_name': taxesName,
        'taxes_description': taxesDescription,
        'taxes_rate': taxesRate,
        'taxes_type': taxesType,
        'taxes_is_active': taxesIsActive,
        'taxes_created_at': taxesCreatedAt,
        'taxes_updated_at': taxesUpdatedAt,
        'taxes_business_id': taxesBusinessId, // Added property
      };

  ProductTaxModel copyWith({
    int? productTaxesId,
    int? productTaxesProductId,
    int? productTaxesTaxId,
    int? productTaxesOrder,
    String? productTaxesCreatedAt,
    int? taxesId,
    String? taxesName,
    String? taxesDescription,
    String? taxesRate,
    String? taxesType,
    int? taxesIsActive,
    String? taxesCreatedAt,
    String? taxesUpdatedAt,
    String? productTaxesApplicationLevel, // Added property
    int? taxesBusinessId, // Added property
  }) {
    return ProductTaxModel(
      productTaxesId: productTaxesId ?? this.productTaxesId,
      productTaxesProductId:
          productTaxesProductId ?? this.productTaxesProductId,
      productTaxesTaxId: productTaxesTaxId ?? this.productTaxesTaxId,
      productTaxesOrder: productTaxesOrder ?? this.productTaxesOrder,
      productTaxesCreatedAt:
          productTaxesCreatedAt ?? this.productTaxesCreatedAt,
      taxesId: taxesId ?? this.taxesId,
      taxesName: taxesName ?? this.taxesName,
      taxesDescription: taxesDescription ?? this.taxesDescription,
      taxesRate: taxesRate ?? this.taxesRate,
      taxesType: taxesType ?? this.taxesType,
      taxesIsActive: taxesIsActive ?? this.taxesIsActive,
      taxesCreatedAt: taxesCreatedAt ?? this.taxesCreatedAt,
      taxesUpdatedAt: taxesUpdatedAt ?? this.taxesUpdatedAt,
      productTaxesApplicationLevel: productTaxesApplicationLevel ??
          this.productTaxesApplicationLevel, // Added property
      taxesBusinessId:
          taxesBusinessId ?? this.taxesBusinessId, // Added property
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      productTaxesId,
      productTaxesProductId,
      productTaxesTaxId,
      productTaxesOrder,
      productTaxesCreatedAt,
      taxesId,
      taxesName,
      taxesDescription,
      taxesRate,
      taxesType,
      taxesIsActive,
      taxesCreatedAt,
      taxesUpdatedAt,
      productTaxesApplicationLevel, // Added property
      taxesBusinessId, // Added property
    ];
  }
}
