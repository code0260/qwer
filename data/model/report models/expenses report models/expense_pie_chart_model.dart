// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';

class ExpensePieChartModel {
  final String category;
  final double totalAmount;
  final double percentage;

  ExpensePieChartModel({
    required this.category,
    required this.totalAmount,
    required this.percentage,
  });

  ExpensePieChartModel copyWith({
    String? category,
    double? totalAmount,
    double? percentage,
  }) {
    return ExpensePieChartModel(
      category: category ?? this.category,
      totalAmount: totalAmount ?? this.totalAmount,
      percentage: percentage ?? this.percentage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'total_amount': totalAmount,
      'percentage': percentage,
    };
  }

  factory ExpensePieChartModel.fromMap(Map<String, dynamic> map) {
    return ExpensePieChartModel(
      category: map['category'] as String,
      totalAmount: receiveDouble(map['total_amount'])!,
      percentage: receiveDouble(map['percentage'])!,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpensePieChartModel.fromJson(String source) =>
      ExpensePieChartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ExpensePieChartModel(category: $category, totalAmount: $totalAmount, percentage: $percentage)';

  @override
  bool operator ==(covariant ExpensePieChartModel other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.totalAmount == totalAmount &&
        other.percentage == percentage;
  }

  @override
  int get hashCode =>
      category.hashCode ^ totalAmount.hashCode ^ percentage.hashCode;
}
