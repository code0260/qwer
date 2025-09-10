import 'package:equatable/equatable.dart';

class AssetModel extends Equatable {
  final int? assetsId;
  final int? assetsBusinessId;
  final String? assetsName;
  final String? assetsCategory;
  final String? assetsPurchaseDate;
  final double? assetsCost;
  final double? assetsBookValue;
  final String? assetsStatus;
  final String? assetsCreatedAt;
  final String? assetsUpdatedAt;
  final int? depreciationId;
  final int? depreciationAssetsId;
  final String? depreciationMethod;
  final int? depreciationAssetUsefulLife;
  final double? depreciationAssetSalvageValue;
  final String? depreciationRate;
  final double? depreciationAccumulatedDepreciation;
  final String? depreciationCreatedAt;
  final String? depreciationUpdatedAt;
  final String? assetsNotes;
  final double? assetsCostInBase;
  final int? assetsCurrencyId;

  const AssetModel({
    this.assetsId,
    this.assetsBusinessId,
    this.assetsName,
    this.assetsCategory,
    this.assetsPurchaseDate,
    this.assetsCost,
    this.assetsBookValue,
    this.assetsStatus,
    this.assetsCreatedAt,
    this.assetsUpdatedAt,
    this.depreciationId,
    this.depreciationAssetsId,
    this.depreciationMethod,
    this.depreciationAssetUsefulLife,
    this.depreciationAssetSalvageValue,
    this.depreciationRate,
    this.depreciationAccumulatedDepreciation,
    this.depreciationCreatedAt,
    this.depreciationUpdatedAt,
    this.assetsNotes,
    this.assetsCostInBase,
    this.assetsCurrencyId,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    double? receiveDouble(dynamic value) {
      if (value == null) return null;
      if (value is num) return value.toDouble();
      return double.tryParse(value.toString());
    }

    return AssetModel(
      assetsId: json['assets_id'] as int?,
      assetsBusinessId: json['assets_business_id'] as int?,
      assetsName: json['assets_name'] as String?,
      assetsCategory: json['assets_category'] as String?,
      assetsPurchaseDate: json['assets_purchase_date'] as String?,
      assetsCost: receiveDouble(json['assets_cost']),
      assetsBookValue: receiveDouble(json['assets_book_value']),
      assetsStatus: json['assets_status'] as String?,
      assetsCreatedAt: json['assets_created_at'] != null
          ? DateTime.parse(json['assets_created_at']).toLocal().toString()
          : null,
      assetsUpdatedAt: json['assets_updated_at'] != null
          ? DateTime.parse(json['assets_updated_at']).toLocal().toString()
          : null,
      depreciationId: json['depreciation_id'] as int?,
      depreciationAssetsId: json['depreciation_assets_id'] as int?,
      depreciationMethod: json['depreciation_method'] as String?,
      depreciationAssetUsefulLife:
          json['depreciation_asset_useful_life'] as int?,
      depreciationAssetSalvageValue:
          receiveDouble(json['depreciation_asset_salvage_value']),
      depreciationRate: json['depreciation_rate'] as String?,
      depreciationAccumulatedDepreciation:
          receiveDouble(json['depreciation_accumulated_depreciation']),
      depreciationCreatedAt: json['depreciation_created_at'] != null
          ? DateTime.parse(json['depreciation_created_at']).toLocal().toString()
          : null,
      depreciationUpdatedAt: json['depreciation_updated_at'] != null
          ? DateTime.parse(json['depreciation_updated_at']).toLocal().toString()
          : null,
      assetsNotes: json['assets_notes'] as String?,
      assetsCostInBase: receiveDouble(json['assets_cost_in_base']),
      assetsCurrencyId: json['assets_currency_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'assets_id': assetsId,
      'assets_business_id': assetsBusinessId,
      'assets_name': assetsName,
      'assets_category': assetsCategory,
      'assets_purchase_date': assetsPurchaseDate,
      'assets_cost': assetsCost,
      'assets_book_value': assetsBookValue,
      'assets_status': assetsStatus,
      'assets_created_at': assetsCreatedAt != null
          ? DateTime.parse(assetsCreatedAt!).toUtc().toString()
          : null,
      'assets_updated_at': assetsUpdatedAt != null
          ? DateTime.parse(assetsUpdatedAt!).toUtc().toString()
          : null,
      'depreciation_id': depreciationId,
      'depreciation_assets_id': depreciationAssetsId,
      'depreciation_method': depreciationMethod,
      'depreciation_asset_useful_life': depreciationAssetUsefulLife,
      'depreciation_asset_salvage_value': depreciationAssetSalvageValue,
      'depreciation_rate': depreciationRate,
      'depreciation_accumulated_depreciation':
          depreciationAccumulatedDepreciation,
      'depreciation_created_at': depreciationCreatedAt != null
          ? DateTime.parse(depreciationCreatedAt!).toUtc().toString()
          : null,
      'depreciation_updated_at': depreciationUpdatedAt != null
          ? DateTime.parse(depreciationUpdatedAt!).toUtc().toString()
          : null,
      'assets_notes': assetsNotes,
      'assets_cost_in_base': assetsCostInBase,
      'assets_currency_id': assetsCurrencyId,
    };
    map.removeWhere((key, value) => value == null || value == '');
    return map;
  }

  AssetModel copyWith({
    int? assetsId,
    int? assetsBusinessId,
    String? assetsName,
    String? assetsCategory,
    String? assetsPurchaseDate,
    double? assetsCost,
    double? assetsBookValue,
    String? assetsStatus,
    String? assetsCreatedAt,
    String? assetsUpdatedAt,
    int? depreciationId,
    int? depreciationAssetsId,
    String? depreciationMethod,
    int? depreciationAssetUsefulLife,
    double? depreciationAssetSalvageValue,
    String? depreciationRate,
    double? depreciationAccumulatedDepreciation,
    String? depreciationCreatedAt,
    String? depreciationUpdatedAt,
    String? assetsNotes,
    double? assetsCostInBase,
    int? assetsCurrencyId,
  }) {
    return AssetModel(
      assetsId: assetsId ?? this.assetsId,
      assetsBusinessId: assetsBusinessId ?? this.assetsBusinessId,
      assetsName: assetsName ?? this.assetsName,
      assetsCategory: assetsCategory ?? this.assetsCategory,
      assetsPurchaseDate: assetsPurchaseDate ?? this.assetsPurchaseDate,
      assetsCost: assetsCost ?? this.assetsCost,
      assetsBookValue: assetsBookValue ?? this.assetsBookValue,
      assetsStatus: assetsStatus ?? this.assetsStatus,
      assetsCreatedAt: assetsCreatedAt ?? this.assetsCreatedAt,
      assetsUpdatedAt: assetsUpdatedAt ?? this.assetsUpdatedAt,
      depreciationId: depreciationId ?? this.depreciationId,
      depreciationAssetsId: depreciationAssetsId ?? this.depreciationAssetsId,
      depreciationMethod: depreciationMethod ?? this.depreciationMethod,
      depreciationAssetUsefulLife:
          depreciationAssetUsefulLife ?? this.depreciationAssetUsefulLife,
      depreciationAssetSalvageValue:
          depreciationAssetSalvageValue ?? this.depreciationAssetSalvageValue,
      depreciationRate: depreciationRate ?? this.depreciationRate,
      depreciationAccumulatedDepreciation:
          depreciationAccumulatedDepreciation ??
              this.depreciationAccumulatedDepreciation,
      depreciationCreatedAt:
          depreciationCreatedAt ?? this.depreciationCreatedAt,
      depreciationUpdatedAt:
          depreciationUpdatedAt ?? this.depreciationUpdatedAt,
      assetsNotes: assetsNotes ?? this.assetsNotes,
      assetsCostInBase: assetsCostInBase ?? this.assetsCostInBase,
      assetsCurrencyId: assetsCurrencyId ?? this.assetsCurrencyId,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      assetsId,
      assetsBusinessId,
      assetsName,
      assetsCategory,
      assetsPurchaseDate,
      assetsCost,
      assetsBookValue,
      assetsStatus,
      assetsCreatedAt,
      assetsUpdatedAt,
      depreciationId,
      depreciationAssetsId,
      depreciationMethod,
      depreciationAssetUsefulLife,
      depreciationAssetSalvageValue,
      depreciationRate,
      depreciationAccumulatedDepreciation,
      depreciationCreatedAt,
      depreciationUpdatedAt,
      assetsNotes,
      assetsCostInBase,
      assetsCurrencyId,
    ];
  }
}
