// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RevenueCategoryInputModel {
  int? revenuesCategoriesId;
  String? revenuesCategoriesName;
  String? revenuesCategoriesDescription;
  String? revenuesCategoriesCreatedAt;
  int? revenuesCategoriesBusinessId;

  RevenueCategoryInputModel({
    this.revenuesCategoriesId,
    this.revenuesCategoriesName,
    this.revenuesCategoriesDescription,
    this.revenuesCategoriesCreatedAt,
    this.revenuesCategoriesBusinessId,
  });

  RevenueCategoryInputModel copyWith({
    int? revenuesCategoriesId,
    String? revenuesCategoriesName,
    String? revenuesCategoriesDescription,
    String? revenuesCategoriesCreatedAt,
    int? revenuesCategoriesBusinessId,
  }) {
    return RevenueCategoryInputModel(
      revenuesCategoriesId: revenuesCategoriesId ?? this.revenuesCategoriesId,
      revenuesCategoriesName:
          revenuesCategoriesName ?? this.revenuesCategoriesName,
      revenuesCategoriesDescription:
          revenuesCategoriesDescription ?? this.revenuesCategoriesDescription,
      revenuesCategoriesCreatedAt:
          revenuesCategoriesCreatedAt ?? this.revenuesCategoriesCreatedAt,
      revenuesCategoriesBusinessId:
          revenuesCategoriesBusinessId ?? this.revenuesCategoriesBusinessId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'revenues_categories_id': revenuesCategoriesId,
      'revenues_categories_name': revenuesCategoriesName,
      'revenues_categories_description': revenuesCategoriesDescription,
      'revenues_categories_created_at':
          parseLocalToUtc(revenuesCategoriesCreatedAt),
      'revenues_categories_business_id': revenuesCategoriesBusinessId,
    };
  }

  factory RevenueCategoryInputModel.fromMap(Map<String, dynamic> map) {
    return RevenueCategoryInputModel(
      revenuesCategoriesId: map['revenues_categories_id'] != null
          ? map['revenues_categories_id'] as int
          : null,
      revenuesCategoriesName: map['revenues_categories_name'] != null
          ? map['revenues_categories_name'] as String
          : null,
      revenuesCategoriesDescription:
          map['revenues_categories_description'] != null
              ? map['revenues_categories_description'] as String
              : null,
      revenuesCategoriesCreatedAt: map['revenues_categories_created_at'] != null
          ? parseUtcToLocal(map['revenues_categories_created_at'] as String)
          : null,
      revenuesCategoriesBusinessId:
          map['revenues_categories_business_id'] != null
              ? map['revenues_categories_business_id'] as int
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RevenueCategoryInputModel.fromJson(String source) =>
      RevenueCategoryInputModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RevenueCategoryInputModel(revenuesCategoriesId: $revenuesCategoriesId, revenuesCategoriesName: $revenuesCategoriesName, revenuesCategoriesDescription: $revenuesCategoriesDescription, revenuesCategoriesCreatedAt: $revenuesCategoriesCreatedAt, revenuesCategoriesBusinessId: $revenuesCategoriesBusinessId)';
  }

  static String? parseUtcToLocal(String? date) {
    return date != null ? DateTime.parse(date).toLocal().toString() : null;
  }

  static String? parseLocalToUtc(String? date) {
    return date != null ? DateTime.parse(date).toUtc().toString() : null;
  }

  @override
  bool operator ==(covariant RevenueCategoryInputModel other) {
    if (identical(this, other)) return true;

    return other.revenuesCategoriesId == revenuesCategoriesId &&
        other.revenuesCategoriesName == revenuesCategoriesName &&
        other.revenuesCategoriesDescription == revenuesCategoriesDescription &&
        other.revenuesCategoriesCreatedAt == revenuesCategoriesCreatedAt &&
        other.revenuesCategoriesBusinessId == revenuesCategoriesBusinessId;
  }

  @override
  int get hashCode {
    return revenuesCategoriesId.hashCode ^
        revenuesCategoriesName.hashCode ^
        revenuesCategoriesDescription.hashCode ^
        revenuesCategoriesCreatedAt.hashCode ^
        revenuesCategoriesBusinessId.hashCode;
  }
}
