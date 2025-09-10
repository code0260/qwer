import 'package:almonazim/core/helper/functions/other%20functions/receive_double.dart';
import 'package:equatable/equatable.dart';

class ExpensesModel extends Equatable {
  final int? expensesId;
  final String? expensesName;
  final dynamic expensesDescription;
  final double? expensesAmount;
  final int? expenseAccountId;
  final String? expensesCreatedAt;
  final String? expensesType;
  final double? expensesSecondAmount;
  final double? expensesAmountInBase; // New property
  final double? expensesSecondAmountInBase; // New property
  final int? expensesAmountCurrencyId; // New property

  const ExpensesModel({
    this.expensesId,
    this.expensesName,
    this.expensesDescription,
    this.expensesAmount,
    this.expenseAccountId,
    this.expensesCreatedAt,
    this.expensesType,
    this.expensesSecondAmount,
    this.expensesAmountInBase, // Added to constructor
    this.expensesSecondAmountInBase, // Added to constructor
    this.expensesAmountCurrencyId, // Added to constructor
  });

  factory ExpensesModel.fromJson(Map<String, dynamic> json) => ExpensesModel(
        expensesId: json['expenses_id'] as int?,
        expensesName: json['expenses_name'] as String?,
        expensesDescription: json['expenses_description'],
        expensesAmount: receiveDouble(json['expenses_amount']),
        expenseAccountId: json['expenses_account_id'] as int?,
        expensesCreatedAt: json['expenses_created_at'] != null
            ? parseUtcToLocal(json['expenses_created_at'] as String)
            : null,
        expensesType: json['expenses_type'] as String?,
        expensesSecondAmount: receiveDouble(json['expenses_second_amount']),
        expensesAmountInBase: receiveDouble(
            json['expenses_amount_in_base']), // Parse new property
        expensesSecondAmountInBase: receiveDouble(
            json['expenses_second_amount_in_base']), // Parse new property
        expensesAmountCurrencyId:
            json['expenses_amount_currency_id'] as int?, // Parse new property
      );

  Map<String, dynamic> toJson() => {
        'expenses_id': expensesId,
        'expenses_name': expensesName,
        'expenses_description': expensesDescription,
        'expenses_amount': expensesAmount,
        'expenses_account_id': expenseAccountId,
        'expenses_created_at': parseLocalToUtc(expensesCreatedAt),
        'expenses_type': expensesType,
        'expenses_second_amount': expensesSecondAmount,
        'expenses_amount_in_base': expensesAmountInBase, // Add new property
        'expenses_second_amount_in_base':
            expensesSecondAmountInBase, // Add new property
        'expenses_amount_currency_id':
            expensesAmountCurrencyId, // Add new property
      };

  ExpensesModel copyWith({
    int? expensesId,
    String? expensesName,
    dynamic expensesDescription,
    double? expensesAmount,
    int? expenseAccountId,
    String? expensesCreatedAt,
    String? expensesType,
    double? expensesSecondAmount,
    double? expensesAmountInBase, // Add new property
    double? expensesSecondAmountInBase, // Add new property
    int? expensesAmountCurrencyId, // Add new property
  }) {
    return ExpensesModel(
      expensesId: expensesId ?? this.expensesId,
      expensesName: expensesName ?? this.expensesName,
      expensesDescription: expensesDescription ?? this.expensesDescription,
      expensesAmount: expensesAmount ?? this.expensesAmount,
      expenseAccountId: expenseAccountId ?? this.expenseAccountId,
      expensesCreatedAt: expensesCreatedAt ?? this.expensesCreatedAt,
      expensesType: expensesType ?? this.expensesType,
      expensesSecondAmount: expensesSecondAmount ?? this.expensesSecondAmount,
      expensesAmountInBase:
          expensesAmountInBase ?? this.expensesAmountInBase, // Add new property
      expensesSecondAmountInBase: expensesSecondAmountInBase ??
          this.expensesSecondAmountInBase, // Add new property
      expensesAmountCurrencyId: expensesAmountCurrencyId ??
          this.expensesAmountCurrencyId, // Add new property
    );
  }

  static String? parseUtcToLocal(String? date) {
    return date != null ? DateTime.parse(date).toLocal().toString() : null;
  }

  static String? parseLocalToUtc(String? date) {
    return date != null ? DateTime.parse(date).toUtc().toString() : null;
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      expensesId,
      expensesName,
      expensesDescription,
      expensesAmount,
      expenseAccountId,
      expensesCreatedAt,
      expensesType,
      expensesSecondAmount,
      expensesAmountInBase, // Add new property
      expensesSecondAmountInBase, // Add new property
      expensesAmountCurrencyId, // Add new property
    ];
  }
}
