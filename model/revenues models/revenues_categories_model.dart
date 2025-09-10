import 'package:equatable/equatable.dart';

class RevenuesCategoriesModel extends Equatable {
  final int? revenuesCategoriesId;
  final String? revenuesCategoriesName;
  final String? revenuesCategoriesDescription;
  final String? revenuesCategoriesCreatedAt;
  final int? revenuesCategoriesBusinessId;

  const RevenuesCategoriesModel({
    this.revenuesCategoriesId,
    this.revenuesCategoriesName,
    this.revenuesCategoriesDescription,
    this.revenuesCategoriesCreatedAt,
    this.revenuesCategoriesBusinessId,
  });

  factory RevenuesCategoriesModel.fromJson(Map<String, dynamic> json) {
    return RevenuesCategoriesModel(
      revenuesCategoriesId: json['revenues_categories_id'] as int?,
      revenuesCategoriesName: json['revenues_categories_name'] as String?,
      revenuesCategoriesDescription:
          json['revenues_categories_description'] as String?,
      revenuesCategoriesCreatedAt: json['revenues_categories_created_at'] !=
              null
          ? parseUtcToLocal(json['revenues_categories_created_at'] as String)
          : null,
      revenuesCategoriesBusinessId:
          json['revenues_categories_business_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'revenues_categories_id': revenuesCategoriesId,
      'revenues_categories_name': revenuesCategoriesName,
      'revenues_categories_description': revenuesCategoriesDescription,
      'revenues_categories_created_at':
          parseLocalToUtc(revenuesCategoriesCreatedAt),
      'revenues_categories_business_id': revenuesCategoriesBusinessId,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  static String? parseUtcToLocal(String? date) {
    return date != null ? DateTime.parse(date).toLocal().toString() : null;
  }

  static String? parseLocalToUtc(String? date) {
    return date != null ? DateTime.parse(date).toUtc().toString() : null;
  }

  @override
  List<Object?> get props {
    return [
      revenuesCategoriesId,
      revenuesCategoriesName,
      revenuesCategoriesDescription,
      revenuesCategoriesCreatedAt,
      revenuesCategoriesBusinessId,
    ];
  }
}
