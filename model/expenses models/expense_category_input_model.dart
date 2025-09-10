// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExpenseCategoryInputModel {
  int? expensesCategoriesId;
  String? expensesCategoriesName;
  String? expensesCategoriesDescription;
  String? expensesCategoriesCreatedAt;
  int? expensesCategoriesBusinessId;

  ExpenseCategoryInputModel({
    this.expensesCategoriesId,
    this.expensesCategoriesName,
    this.expensesCategoriesDescription,
    this.expensesCategoriesCreatedAt,
    this.expensesCategoriesBusinessId,
  });

  ExpenseCategoryInputModel copyWith({
    int? expensesCategoriesId,
    String? expensesCategoriesName,
    String? expensesCategoriesDescription,
    String? expensesCategoriesCreatedAt,
    int? expensesCategoriesBusinessId,
  }) {
    return ExpenseCategoryInputModel(
      expensesCategoriesId: expensesCategoriesId ?? this.expensesCategoriesId,
      expensesCategoriesName:
          expensesCategoriesName ?? this.expensesCategoriesName,
      expensesCategoriesDescription:
          expensesCategoriesDescription ?? this.expensesCategoriesDescription,
      expensesCategoriesCreatedAt:
          expensesCategoriesCreatedAt ?? this.expensesCategoriesCreatedAt,
      expensesCategoriesBusinessId:
          expensesCategoriesBusinessId ?? this.expensesCategoriesBusinessId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'expenses_categories_id': expensesCategoriesId,
      'expenses_categories_name': expensesCategoriesName,
      'expenses_categories_description': expensesCategoriesDescription,
      'expenses_categories_created_at':
          parseLocalToUtc(expensesCategoriesCreatedAt),
      'expenses_categories_business_id': expensesCategoriesBusinessId,
    };
  }

  factory ExpenseCategoryInputModel.fromMap(Map<String, dynamic> map) {
    return ExpenseCategoryInputModel(
      expensesCategoriesId: map['expenses_categories_id'] != null
          ? map['expenses_categories_id'] as int
          : null,
      expensesCategoriesName: map['expenses_categories_name'] != null
          ? map['expenses_categories_name'] as String
          : null,
      expensesCategoriesDescription:
          map['expenses_categories_description'] != null
              ? map['expenses_categories_description'] as String
              : null,
      expensesCategoriesCreatedAt: map['expenses_categories_created_at'] != null
          ? parseUtcToLocal(map['expenses_categories_created_at'] as String)
          : null,
      expensesCategoriesBusinessId:
          map['expenses_categories_business_id'] != null
              ? map['expenses_categories_business_id'] as int
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseCategoryInputModel.fromJson(String source) =>
      ExpenseCategoryInputModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExpenseCategoryInputModel(expensesCategoriesId: $expensesCategoriesId, expensesCategoriesName: $expensesCategoriesName, expensesCategoriesDescription: $expensesCategoriesDescription, expensesCategoriesCreatedAt: $expensesCategoriesCreatedAt, expensesCategoriesBusinessId: $expensesCategoriesBusinessId)';
  }

  static String? parseUtcToLocal(String? date) {
    return date != null ? DateTime.parse(date).toLocal().toString() : null;
  }

  static String? parseLocalToUtc(String? date) {
    return date != null ? DateTime.parse(date).toUtc().toString() : null;
  }

  @override
  bool operator ==(covariant ExpenseCategoryInputModel other) {
    if (identical(this, other)) return true;

    return other.expensesCategoriesId == expensesCategoriesId &&
        other.expensesCategoriesName == expensesCategoriesName &&
        other.expensesCategoriesDescription == expensesCategoriesDescription &&
        other.expensesCategoriesCreatedAt == expensesCategoriesCreatedAt &&
        other.expensesCategoriesBusinessId == expensesCategoriesBusinessId;
  }

  @override
  int get hashCode {
    return expensesCategoriesId.hashCode ^
        expensesCategoriesName.hashCode ^
        expensesCategoriesDescription.hashCode ^
        expensesCategoriesCreatedAt.hashCode ^
        expensesCategoriesBusinessId.hashCode;
  }
}
