// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:almonazim/data/model/expenses%20models/expenses_summary_model.dart';
import 'package:flutter/foundation.dart';

import 'package:almonazim/data/model/expenses%20models/expenses_model.dart';

class GetExpensesModel {
  final List<ExpensesModel> expenses;
  final ExpensesSummaryModel expensesSummaryModel;

  GetExpensesModel({
    required this.expenses,
    required this.expensesSummaryModel,
  });

  GetExpensesModel copyWith({
    List<ExpensesModel>? expenses,
    ExpensesSummaryModel? expensesSummaryModel,
  }) {
    return GetExpensesModel(
      expenses: expenses ?? this.expenses,
      expensesSummaryModel: expensesSummaryModel ?? this.expensesSummaryModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'expenses': expenses.map((x) => x.toJson()).toList(),
      'expensesSummaryModel': expensesSummaryModel.toJson(),
    };
  }

  factory GetExpensesModel.fromMap(Map<String, dynamic> map) {
    return GetExpensesModel(
      expenses: List<ExpensesModel>.from(
        (map['expenses'] as List<int>).map<ExpensesModel>(
          (x) => ExpensesModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      expensesSummaryModel:
          map['expenses_summary_model'] as ExpensesSummaryModel,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetExpensesModel.fromJson(String source) =>
      GetExpensesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ExpensesModel(expenses: $expenses, expensesSummaryModel: $expensesSummaryModel)';

  @override
  bool operator ==(covariant GetExpensesModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.expenses, expenses) &&
        other.expensesSummaryModel == expensesSummaryModel;
  }

  @override
  int get hashCode => expenses.hashCode ^ expensesSummaryModel.hashCode;
}
