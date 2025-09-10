import 'package:equatable/equatable.dart';

class ExpensesCategoriesModel extends Equatable {
  final int? expensesCategoriesId;
  final String? expensesCategoriesName;
  final String? expensesCategoriesDescription;
  final String? expensesCategoriesCreatedAt;
  final int? expensesCategoriesBusinessId;

  const ExpensesCategoriesModel({
    this.expensesCategoriesId,
    this.expensesCategoriesName,
    this.expensesCategoriesDescription,
    this.expensesCategoriesCreatedAt,
    this.expensesCategoriesBusinessId,
  });

  factory ExpensesCategoriesModel.fromJson(Map<String, dynamic> json) {
    return ExpensesCategoriesModel(
      expensesCategoriesId: json['expenses_categories_id'] as int?,
      expensesCategoriesName: json['expenses_categories_name'] as String?,
      expensesCategoriesDescription:
          json['expenses_categories_description'] as String?,
      expensesCategoriesCreatedAt: json['expenses_categories_created_at'] !=
              null
          ? parseUtcToLocal(json['expenses_categories_created_at'] as String)
          : null,
      expensesCategoriesBusinessId:
          json['expenses_categories_business_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'expenses_categories_id': expensesCategoriesId,
      'expenses_categories_name': expensesCategoriesName,
      'expenses_categories_description': expensesCategoriesDescription,
      'expenses_categories_created_at':
          parseLocalToUtc(expensesCategoriesCreatedAt),
      'expenses_categories_business_id': expensesCategoriesBusinessId,
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
      expensesCategoriesId,
      expensesCategoriesName,
      expensesCategoriesDescription,
      expensesCategoriesCreatedAt,
      expensesCategoriesBusinessId,
    ];
  }
}
