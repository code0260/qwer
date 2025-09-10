// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore: must_be_immutable
class ExpenseInputModel {
  DateTime? startDate;
  DateTime? endDate;
  int? expensesId;
  int? expensesAccountId;
  String? expensesName;
  dynamic expensesDescription;
  double? expensesAmount; // Changed from String to double
  String? expensesCreatedAt;
  String? expensesType;
  double? expensesSecondAmount; // Changed from String to double
  double? paidThisTime;
  int? paidThisTimeCurrencyId;
  double? paidThisTimeInBase;
  String? originalType;

  // New properties
  double? expensesAmountInBase;
  double? expensesSecondAmountInBase;
  int? expensesAmountCurrencyId;

  ExpenseInputModel({
    this.paidThisTime,
    this.paidThisTimeInBase,
    this.expensesAccountId,
    this.startDate,
    this.endDate,
    this.expensesId,
    this.paidThisTimeCurrencyId,
    this.expensesName,
    this.expensesDescription,
    this.expensesAmount,
    this.expensesCreatedAt,
    this.expensesType,
    this.expensesSecondAmount,
    this.expensesAmountInBase, // New property
    this.expensesSecondAmountInBase, // New property
    this.expensesAmountCurrencyId, // New property
    this.originalType,
  });

  ExpenseInputModel copyWith({
    int? employeeId,
    DateTime? startDate,
    DateTime? endDate,
    String? expensesType,
    double? expensesSecondAmount, // Updated type
    double? expensesAmountInBase, // New property
    double? expensesSecondAmountInBase, // New property
    int? expensesAmountCurrencyId, // New property
  }) {
    return ExpenseInputModel(
      expensesAccountId: employeeId ?? expensesAccountId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      expensesId: expensesId,
      expensesName: expensesName,
      expensesDescription: expensesDescription,
      expensesAmount: expensesAmount,
      expensesCreatedAt: expensesCreatedAt,
      expensesType: expensesType ?? this.expensesType,
      expensesSecondAmount: expensesSecondAmount ?? this.expensesSecondAmount,
      expensesAmountInBase:
          expensesAmountInBase ?? this.expensesAmountInBase, // New property
      expensesSecondAmountInBase: expensesSecondAmountInBase ??
          this.expensesSecondAmountInBase, // New property
      expensesAmountCurrencyId: expensesAmountCurrencyId ??
          this.expensesAmountCurrencyId, // New property
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'expenses_account_id': expensesAccountId,
      'start_date': startDate?.toUtc().toString(),
      'end_date': endDate?.toUtc().toString(),
      'expenses_id': expensesId,
      'expenses_name': expensesName,
      'expenses_description': expensesDescription,
      'expenses_amount': expensesAmount, // Updated type
      'expenses_created_at': expensesCreatedAt == null
          ? null
          : DateTime.parse(expensesCreatedAt!).toUtc().toString(),
      'expenses_type': expensesType,
      'expenses_second_amount': expensesSecondAmount, // Updated type
      'expenses_amount_in_base': expensesAmountInBase, // New property
      'expenses_second_amount_in_base':
          expensesSecondAmountInBase, // New property
      'expenses_amount_currency_id': expensesAmountCurrencyId, // New property
    };
    map.removeWhere((key, value) => value == null || value == "all");
    return map;
  }

  factory ExpenseInputModel.fromMap(Map<String, dynamic> map) {
    return ExpenseInputModel(
      expensesAccountId: map['expenses_account_id'] as int?,
      startDate: map['start_date'] != null
          ? DateTime.parse(map['start_date']).toLocal()
          : null,
      endDate: map['end_date'] != null
          ? DateTime.parse(map['end_date']).toLocal()
          : null,
      expensesId: map['expenses_id'] as int?,
      expensesName: map['expenses_name'] as String?,
      expensesDescription: map['expenses_description'],
      expensesAmount: map['expenses_amount'] != null
          ? double.tryParse(map['expenses_amount'].toString()) // Updated type
          : null,
      expensesCreatedAt: map['expenses_created_at'] == null
          ? null
          : DateTime.parse('${map['expenses_created_at']}Z')
              .toLocal()
              .toString(),
      expensesType: map['expenses_type'] as String?,
      expensesSecondAmount: map['expenses_second_amount'] != null
          ? double.tryParse(
              map['expenses_second_amount'].toString()) // Updated type
          : null,
      expensesAmountInBase: map['expenses_amount_in_base'] != null
          ? double.tryParse(
              map['expenses_amount_in_base'].toString()) // New property
          : null,
      expensesSecondAmountInBase: map['expenses_second_amount_in_base'] != null
          ? double.tryParse(
              map['expenses_second_amount_in_base'].toString()) // New property
          : null,
      expensesAmountCurrencyId:
          map['expenses_amount_currency_id'] as int?, // New property
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseInputModel.fromJson(String source) =>
      ExpenseInputModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
