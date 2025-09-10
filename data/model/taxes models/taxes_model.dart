import 'package:equatable/equatable.dart';

class TaxesModel extends Equatable {
  final int? taxesId;
  final String? taxesName;
  final String? taxesDescription;
  final String? taxesRate;
  final String? taxesType;
  final int? taxesIsActive;
  final String? taxesCreatedAt;
  final String? taxesUpdatedAt;
  final int? taxesBusinessId; // Added property

  const TaxesModel({
    this.taxesId,
    this.taxesName,
    this.taxesDescription,
    this.taxesRate,
    this.taxesType,
    this.taxesIsActive,
    this.taxesCreatedAt,
    this.taxesUpdatedAt,
    this.taxesBusinessId, // Added property
  });

  factory TaxesModel.fromJson(Map<String, dynamic> json) => TaxesModel(
        taxesId: json['taxes_id'] as int?,
        taxesName: json['taxes_name'] as String?,
        taxesDescription: json['taxes_description'] as String?,
        taxesRate: json['taxes_rate'] as String?,
        taxesType: json['taxes_type'] as String?,
        taxesIsActive: json['taxes_is_active'] as int?,
        taxesCreatedAt: json['taxes_created_at'] as String?,
        taxesUpdatedAt: json['taxes_updated_at'] as String?,
        taxesBusinessId: json['taxes_business_id'] as int?, // Added property
      );

  Map<String, dynamic> toJson() => {
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

  TaxesModel copyWith({
    int? taxesId,
    String? taxesName,
    String? taxesDescription,
    String? taxesRate,
    String? taxesType,
    int? taxesIsActive,
    String? taxesCreatedAt,
    String? taxesUpdatedAt,
    int? taxesBusinessId, // Added property
  }) {
    return TaxesModel(
      taxesId: taxesId ?? this.taxesId,
      taxesName: taxesName ?? this.taxesName,
      taxesDescription: taxesDescription ?? this.taxesDescription,
      taxesRate: taxesRate ?? this.taxesRate,
      taxesType: taxesType ?? this.taxesType,
      taxesIsActive: taxesIsActive ?? this.taxesIsActive,
      taxesCreatedAt: taxesCreatedAt ?? this.taxesCreatedAt,
      taxesUpdatedAt: taxesUpdatedAt ?? this.taxesUpdatedAt,
      taxesBusinessId:
          taxesBusinessId ?? this.taxesBusinessId, // Added property
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      taxesId,
      taxesName,
      taxesDescription,
      taxesRate,
      taxesType,
      taxesIsActive,
      taxesCreatedAt,
      taxesUpdatedAt,
      taxesBusinessId, // Added property
    ];
  }
}
